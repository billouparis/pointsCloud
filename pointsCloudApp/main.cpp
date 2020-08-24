
#include <QGuiApplication>
#include <Qt3DQuickExtras/Qt3DQuickWindow>
#include <QtQuick/QQuickView>

#include <QQmlContext>
#include <QQmlAspectEngine>

#include <localsocketclient.h>
#include <pointsCloud.h>


int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    //Qt3DExtras::Quick::Qt3DQuickWindow * pView = new Qt3DExtras::Quick::Qt3DQuickWindow(nullptr);
    // Create a regular QQuickView to mix with a 3D Scene
    QQuickView * pView = new QQuickView(nullptr);

    LocalSocketClient *pLocalSocketClient = LocalSocketClient::getInstance();
    pLocalSocketClient->initialize();

    // Create one instance of the PointsCloud class
    // THis class creates a Qt3D QtRender Buffer to be used by the 3D Entity
    PointsCloud *pPointsCloud = new PointsCloud(pView);
    // Initialize for set of buffer data
    pPointsCloud->initialize();

    // Export the a Qt3D QtRender Buffer reference in QML context
    //pView->engine()->qmlEngine()->rootContext()->setContextProperty("pointsCloud", pPointsCloud);
    pView->rootContext()->setContextProperty("pointsCloud", pPointsCloud);

    // Load main Qt3D Quick Window
    pView->setSource(QUrl("main.qml"));
    pView->show();

    return app.exec();
}
