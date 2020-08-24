#ifndef DATAMODEL_H
#define DATAMODEL_H
#include <Qt3DCore>
#include <QVector3D>
#include <Qt3DRender>
/*
 * This struct is not strictly necessary, it is just convenient in case more
 * vertex attributes are needed. If so, it is necessary to change the ByteStride
 * in the geometry attribute.
 */
struct DrawVBOData {
    QVector3D position;
};

class DataModel : public Qt3DCore::QNode {
    Q_OBJECT
    // Make properties available in QML
    Q_PROPERTY(Qt3DRender::QBuffer *buffer READ buffer CONSTANT)
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    explicit DataModel (Qt3DCore::QNode *parent = 0);
    Qt3DRender::QBuffer *buffer();
    void setData(const QVector<QVector3D> &positions);
    int count() const;

signals:
    void countChanged(int count);

public slots:

private:
    QScopedPointer<Qt3DRender::QBuffer> m_buffer;
    int m_count = 0;
};

#endif // DATAMODEL_H
