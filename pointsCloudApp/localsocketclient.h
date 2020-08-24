#ifndef LOCALSOCKETSERVER_H
#define LOCALSOCKETSERVER_H

#include <QObject>
#include <QLocalSocket>

class LocalSocketClient: public QObject
{
    Q_OBJECT
public:
    LocalSocketClient(QObject *parent);

    void initialize();
    void connectToServer();
    static LocalSocketClient* getInstance();

signals:
    void sgnNewData();

public slots:
    void sltReadInSocket();
    void displayErrorB(QLocalSocket::LocalSocketError socketError);


private:
    QLocalSocket *m_pQLocalSocket;
    static LocalSocketClient *m_pLocalSocketClientInstance;
};

Q_DECLARE_METATYPE(QLocalSocket::LocalSocketError);

#endif // LOCALSOCKETSERVER_H
