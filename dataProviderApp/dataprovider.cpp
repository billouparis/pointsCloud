#include "dataprovider.h"
#include <QTimer>
#include <qmath.h>
#include <QDebug>
#include <localsocketserver.h>

#define SHAREDMEMORY_NAME "pointsCloudSHM"
#define POINTSCLOUD_WIDTH 640
#define POINTSCLOUD_HEIGHT 480
#define POINTSCLOUD_FPS 60


DataProvider::DataProvider(QObject *parent) : QObject(parent)
{

    // number of vertices
    m_pointsCount = POINTSCLOUD_WIDTH * POINTSCLOUD_HEIGHT;
    // SHM
    m_pQSharedMemory = new QSharedMemory(SHAREDMEMORY_NAME);
    m_pQByteArray = nullptr;
    m_bOffOn = false;
    m_bRandom = false;

}

void DataProvider::Initialize()
{
    qDebug() << Q_FUNC_INFO;

    bool bBool = false;
    // Initializa the Shared Memory Segment
    // SHM size : number of vertices time 3 coordinate in float format
    m_pQSharedMemory->setKey(SHAREDMEMORY_NAME);
    bBool = m_pQSharedMemory->create(m_pointsCount * 3 * sizeof(float));
    if (false == bBool)
    {
        qDebug() << "Impossible to create the SHM";
    }
    else
    {
        qDebug() << "SHM created successfully";
    }

    // Shared memory is attached by default, but just perform an additional check
    bBool = m_pQSharedMemory->isAttached();
    if (false == bBool)
    {
        qDebug() << "Impossible to attach to SHM" << m_pQSharedMemory->errorString();
    }

    // Main Timer for the data generation frequency
    // Start timer for next update
    QTimer *timer = new QTimer;
    timer->setInterval(1000.0 / POINTSCLOUD_FPS );
    timer->setSingleShot(false);
    connect(timer, &QTimer::timeout, this, &DataProvider::sltGenerateData);

    timer->start();
}

void DataProvider::sltGenerateData()
{
    //    qDebug() << Q_FUNC_INFO;

    if (nullptr == m_pQByteArray)
    {
        // Allocate the QByteArray - vector of size of QVector3D ( 3 floats = 12 bytes)
        m_pQByteArray = new QByteArray;
        m_pQByteArray->resize(m_pointsCount * 3 * sizeof(float));
    }

    if (true == m_bOffOn)
    {
        //points to the QByteArray - vector of size of QVector3D ( 3 floats = 12 bytes)
        QVector3D *vboData = reinterpret_cast<QVector3D *>(m_pQByteArray->data());
        int iCurrentVertex = 0;
        for (int xIndex = 0; xIndex < POINTSCLOUD_WIDTH; xIndex ++)
        {
            for (int yIndex = 0; yIndex < POINTSCLOUD_HEIGHT; yIndex ++)
            {
                QVector3D *vbo = &vboData[iCurrentVertex];

                float x = (float) xIndex / (float)(POINTSCLOUD_WIDTH - 1);
                // Compute the Y with the image ratio
                float y = ((float) yIndex / (float)(POINTSCLOUD_HEIGHT - 1))
                        * ((float)(POINTSCLOUD_HEIGHT - 1) / (float) (POINTSCLOUD_WIDTH - 1)) ;
                // Store a 0 to 1 variable.
                float tempY = ((float) yIndex / (float)(POINTSCLOUD_HEIGHT - 1));
                vbo->setX(x );
                vbo->setY(y );
                if (true == m_bRandom)
                {
                    // Generate Random Data
                    vbo->setZ((float) rand() / (float)(RAND_MAX));
                }
                else
                {
                    // Generate 3D Curve
                    vbo->setZ((float) sin (tempY * M_PI) * cos ((- M_PI / 2.) + (x * M_PI)));
                }

                iCurrentVertex++;
            }
        }
    }
    else
    {
        m_pQByteArray->fill(0x00, m_pointsCount * 3 * sizeof(float));
    }
    // Update the SharedMemory data
    provideDataInSharedMemory();
}

void DataProvider::provideDataInSharedMemory()
{
    //    qDebug() << Q_FUNC_INFO;

    m_pQSharedMemory->lock();
    memcpy(m_pQSharedMemory->data(), m_pQByteArray->data(), m_pQByteArray->count());
    m_pQSharedMemory->unlock();

    // When data is ready then notify one update in the localServer using the localSocket
    // create socket and write regular message
    LocalSocketServer *pLocalSocketServer = LocalSocketServer::getInstance();
    pLocalSocketServer->writeInSocket();

}

