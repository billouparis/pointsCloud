#ifndef DATAPROVIDER_H
#define DATAPROVIDER_H
#include <QObject>
#include <QSharedMemory>
#include <QVector3D>

class DataProvider: public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool bRandom READ bRandom WRITE setBRandom NOTIFY bRandomChanged)
    Q_PROPERTY(bool bOffOn READ bOffOn WRITE setBOffOn NOTIFY bOffOnChanged)


public:
    DataProvider(QObject *parent);

public slots:
    void sltGenerateData();


    void setBRandom(bool bRandom)
    {
        m_bRandom = bRandom;
        emit bRandomChanged(m_bRandom);
    }

    void setBOffOn(bool bOffOn)
    {
        m_bOffOn = bOffOn;
        emit bOffOnChanged(m_bOffOn);
    }

public:
     QSharedMemory *m_pQSharedMemory;

     void Initialize();
     void provideDataInSharedMemory();

     QByteArray *m_pQByteArray;
     int m_pointsCount;

     bool bRandom() const
     {
         return m_bRandom;
     }
     bool bOffOn() const
     {
         return m_bOffOn;
     }

signals:
     void bRandomChanged(bool bRandom);
     void bOffOnChanged(bool BOffOn);

private:
     bool m_bRandom;
     bool m_bOffOn;
};

#endif // DATAPROVIDER_H
