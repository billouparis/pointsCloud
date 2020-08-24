#include "localsocketserver.h"
#include <QTimer>
#include <QDebug>


#define DATAPROVIDER_REFRESH_RATE 2
#define DATAPROVIDER_SOCKET_SERVER_NAME "dataProvider"

LocalSocketServer *LocalSocketServer::m_pLocalSocketServerInstance = nullptr;

LocalSocketServer* LocalSocketServer::getInstance()
{
    if (nullptr == m_pLocalSocketServerInstance)
    {
        m_pLocalSocketServerInstance = new LocalSocketServer(nullptr);

    }
    return m_pLocalSocketServerInstance;
}


LocalSocketServer::LocalSocketServer(QObject *parent)
{
    qDebug() << Q_FUNC_INFO;
    // Initialize the default qLocalSocket
    m_pQLocalSocket = nullptr;
}

void LocalSocketServer::initialize()
{
    qDebug() << Q_FUNC_INFO;

    // Start to listen on the Socket Server Name
    listen(DATAPROVIDER_SOCKET_SERVER_NAME);

    // When a sockets connects to the server, just initialize the local socket pointer
    // with the returned value of the new connection call
    connect(this, &QLocalServer::newConnection, this, &LocalSocketServer::sltNewConnection);

    // Create signals slot connection
    //connect(m_pQLocalSocket, &QLocalSocket::connected, this, &LocalSocketServer::sltWriteInSocket);

    connect(m_pQLocalSocket, &QLocalSocket::bytesWritten,
            this, &LocalSocketServer::bytesWrittenC);
    connect(m_pQLocalSocket, &QLocalSocket::readyRead,
            this, &LocalSocketServer::readyReadC);

}


void LocalSocketServer::bytesWrittenC(qint64 b){
//    qDebug()<<"Data is ready in the socket";
}

void LocalSocketServer::readyReadC(){
//    qDebug()<<"Ready to read data";
}

void LocalSocketServer::sltNewConnection()
{
    qDebug() << Q_FUNC_INFO ;
    // Initialize local socket upon reception of a new connection (from the client)
    m_pQLocalSocket = nextPendingConnection();
}


void LocalSocketServer::writeInSocket()
{
//    qDebug() << Q_FUNC_INFO;

    bool bBool = false;
    // If a socket is connected to the server, write data to this socket
    if (m_pQLocalSocket != nullptr)
    {
        // Write dummy data
        const char data = 0xDD;
        m_pQLocalSocket->write(&data, 1);
        // Ensure data is written in less than 2ms
        // Blocking call
        bBool = m_pQLocalSocket->waitForBytesWritten(2000);
        if (false == bBool)
        {
            qDebug() <<  "data not written in less than 2000ms";
        }
        else
        {
            qDebug() <<  "data written in less than 2000ms";
        }
    }
    else
    {
         qDebug() <<  "No Socket available to write into";
    }
}


