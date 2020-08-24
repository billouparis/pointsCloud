
#include <QCoreApplication>
#include <QGuiApplication>
#include <QtQuick/QQuickView>

#include <QQmlContext>
#include <QQmlAspectEngine>

#include <localsocketserver.h>
#include <dataprovider.h>


int main(int argc, char* argv[])
{
    //QCoreApplication app(argc, argv);
    QGuiApplication app(argc, argv);

    // create socket server, wait of a local socket connection and then write data in this socket
    LocalSocketServer *pLocalSocketServer = LocalSocketServer::getInstance();
    pLocalSocketServer->initialize();

    // Create main data provider class
    // Generate dummy data
    // Dump data in the SharedMemory
    // Notify the local socket that new data is ready with a dummy data (one byte)
    DataProvider *pDataProvider = new DataProvider(&app);
    pDataProvider->Initialize();

    // Main view to allow the generated shape
    QQuickView * pView = new QQuickView(nullptr);
    pView->rootContext()->setContextProperty("dataProvider", pDataProvider);

    // Load main Qt3D Quick Window
    pView->setSource(QUrl("main.qml"));
    pView->show();

    return app.exec();
}
