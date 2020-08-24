#include <localsocketclient.h>
#include <QTimer>
#include <QDebug>


#define DATAPROVIDER_REFRESH_RATE 2
#define DATAPROVIDER_SOCKET_SERVER_NAME "dataProvider"

LocalSocketClient *LocalSocketClient::m_pLocalSocketClientInstance = nullptr;


LocalSocketClient* LocalSocketClient::getInstance()
{
    if (nullptr == m_pLocalSocketClientInstance)
    {
        m_pLocalSocketClientInstance = new LocalSocketClient(nullptr);

    }
    return m_pLocalSocketClientInstance;
}


LocalSocketClient::LocalSocketClient(QObject *parent)
{
    qRegisterMetaType<QLocalSocket::LocalSocketError>();
    qDebug() << Q_FUNC_INFO;
    // Create a qLocalSocket
    m_pQLocalSocket = new QLocalSocket(parent);
}

void LocalSocketClient::initialize()
{
    qDebug() << Q_FUNC_INFO;
    // Create a qLocalSocket
    // And Connect to existing Server
    m_pQLocalSocket->setServerName(DATAPROVIDER_SOCKET_SERVER_NAME);
    connectToServer();

}


void LocalSocketClient::displayErrorB(QLocalSocket::LocalSocketError socketError)
{
    Q_UNUSED(socketError);
    qDebug () << m_pQLocalSocket->errorString();
}

void LocalSocketClient::connectToServer()
{
    qDebug() << Q_FUNC_INFO;
    bool bBool = false;
    // connect to Socket server
    m_pQLocalSocket->connectToServer();
    bBool = m_pQLocalSocket->waitForConnected();
    if (false == bBool)
    {
        qDebug() <<  m_pQLocalSocket->error();
    }
    else
    {
        qDebug() <<  "Socket Connected to Server succesfully";
        // Add a connection to watch out errors
        connect(m_pQLocalSocket,
                QOverload<QLocalSocket::LocalSocketError>::of(&QLocalSocket::error),
                this,
                &LocalSocketClient::displayErrorB);

        // Add a connection to read data when available in the socket
        connect(m_pQLocalSocket, &QLocalSocket::readyRead,
                this, &LocalSocketClient::sltReadInSocket);
    }
}


void LocalSocketClient::sltReadInSocket()
{
  //  qDebug() << Q_FUNC_INFO;

    char data;
    m_pQLocalSocket->read(&data, 1);
    // Send a new message when data are available
    // THe points cloud class is connected to this message,
    // to read new SHared Memory Data
    emit sgnNewData();
}


