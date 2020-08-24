#ifndef POINTSCLOUD_H
#define POINTSCLOUD_H

#include <Qt3DRender>
#include <Qt3DRender/QBuffer>
#include <QVector3D>
#include <localsocketclient.h>

class PointsCloud: public QObject
{
    Q_OBJECT

    Q_PROPERTY(int pointsCount READ pointsCount WRITE setPointsCount NOTIFY pointsCountChanged)
    Q_PROPERTY(Qt3DRender::QBuffer *buffer READ buffer WRITE setBuffer NOTIFY bufferChanged)


public:
    PointsCloud(QObject *parent = 0);
    ~PointsCloud();


    void initialize();
    void outputData();

    int pointsCount() const { return m_pointsCount; }

    void setPointsCount(int count);

    void setBuffer(Qt3DRender::QBuffer * buffer)
    {
        if (m_pBuffer == buffer)
            return;

        m_pBuffer = buffer;
        emit bufferChanged(m_pBuffer);
    }

    Qt3DRender::QBuffer* buffer() const
    {
        return m_pBuffer;
    }

public slots:
    void sltInitializeData();

signals:
    void pointsCountChanged(int count);
    void bufferChanged(Qt3DRender::QBuffer* buffer);

private:
    QSharedMemory *m_pQSharedMemory;
    int m_pointsCount;
    Qt3DRender::QBuffer * m_pBuffer;


    // When data is ready then notify one update in the localServer using the localSocket
    // create socket and write regular message
    LocalSocketClient *pLocalSocketClient;
};

#endif
