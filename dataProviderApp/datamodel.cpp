#include "datamodel.h"

DataModel::DataModel(Qt3DCore::QNode *parent)
    : Qt3DCore::QNode(parent), m_buffer(new Qt3DRender::QBuffer(Qt3DRender::QBuffer::VertexBuffer, this)){}

Qt3DRender::QBuffer *DataModel::buffer() { return m_buffer.data();}

void DataModel::setData(const QVector<QVector3D> &positions) {
    QByteArray ba;
    ba.resize(positions.size() * sizeof(DrawVBOData));
    DrawVBOData *vboData = reinterpret_cast<DrawVBOData *>(ba.data());
    for (int i = 0; i < positions.size(); i++) {
        DrawVBOData &vbo = vboData[i];
        vbo.position = positions[i];
    }
    m_buffer->setData(ba);
    m_count = positions.count();
    emit countChanged(m_count);
}

int DataModel::count() const { return m_count; }
