#include <Qt3DRender/QBuffer>
#include <pointsCloud.h>
#include <qmap.h>
#include "localsocketclient.h"

#define SHAREDMEMORY_NAME "pointsCloudSHM"
#define POINTSCLOUD_WIDTH 640
#define POINTSCLOUD_HEIGHT 480
#define POINTSCLOUD_FPS 2

PointsCloud::PointsCloud(QObject *parent)
    : QObject(parent)
{
    m_pQSharedMemory = new QSharedMemory(SHAREDMEMORY_NAME);
    m_pBuffer = new Qt3DRender::QBuffer( nullptr);
    pLocalSocketClient = LocalSocketClient::getInstance();
}

PointsCloud::~PointsCloud()
{

}


void PointsCloud::initialize()
{
  //  qDebug() << Q_FUNC_INFO;
    bool bBool = false;

    // Initialize the points cloud count = number of vertices
    setPointsCount(POINTSCLOUD_WIDTH * POINTSCLOUD_HEIGHT);

    // Fill buffer with zero data to avoid crash
    QByteArray dummyArray;
    dummyArray.resize(m_pointsCount * 3 * sizeof(float));
    dummyArray.fill(0x00, m_pointsCount * 3 * sizeof(float));
    m_pBuffer->setData(dummyArray);

    // Connect to existin g Shared Memory buffer
    m_pQSharedMemory->setKey(SHAREDMEMORY_NAME);
    bBool = m_pQSharedMemory->attach();
    if (false == bBool)
    {
        qDebug() << "Impossible to attach to SHM" << m_pQSharedMemory->errorString();
    }
    else
    {
        qDebug() << "Correctly attached to SHM" << m_pQSharedMemory->errorString();

    }

    // Connect the localsocketclient
    // When new data arrived, then reload the Data from the SHM
    connect(pLocalSocketClient, &LocalSocketClient::sgnNewData,
            this, &PointsCloud::sltInitializeData);

}


void PointsCloud::sltInitializeData()
{
  //  qDebug() << Q_FUNC_INFO;

    // Read data from SHM
    // We store the new data in a new QByteArray each time (maybe not very efficient?)

    QByteArray tmp;
    tmp.resize(m_pointsCount * 3 * sizeof(float));

    m_pQSharedMemory->lock();
    memcpy(tmp.data(), m_pQSharedMemory->data(),  m_pointsCount * 3 * sizeof(float));
    m_pQSharedMemory->unlock();
    m_pBuffer->setData(tmp);
}

void PointsCloud::outputData()
{
    // Debug function
    for (int index = 64566; index < 64566 + 20; index ++)
    {
        // qDebug() << Q_FUNC_INFO << (m_pBuffer->data ()[index]);
    }
}

void PointsCloud::setPointsCount(int count)
{
    m_pointsCount = count;
    emit pointsCount();
}
