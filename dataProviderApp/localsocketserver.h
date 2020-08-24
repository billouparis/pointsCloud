#ifndef LOCALSOCKETSERVER_H
#define LOCALSOCKETSERVER_H

#include <QObject>
#include <QLocalServer>
#include <QLocalSocket>

class LocalSocketServer: public QLocalServer
{
public:
    LocalSocketServer(QObject *parent);

    void initialize();
    void connectToServer();
    static LocalSocketServer* getInstance();
    void writeInSocket();

public slots:
   // void sltSendMessage();
    void bytesWrittenC(qint64 b);
    void readyReadC();

    void sltNewConnection();

private:
    QLocalSocket *m_pQLocalSocket;
     static LocalSocketServer *m_pLocalSocketServerInstance;
};

#endif // LOCALSOCKETSERVER_H
