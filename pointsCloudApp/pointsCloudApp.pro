
QT += 3dcore 3drender 3dinput 3dquick 3dlogic qml quick 3dquickextras

SOURCES += \
    localsocketclient.cpp \
    main.cpp \
    pointsCloud.cpp

RESOURCES +=

OTHER_FILES += \
    doc/src/*.*

HEADERS += \
    localsocketclient.h \
    pointsCloud.h

DISTFILES += \
    CameraControls.qml \
    CoordinatesSystem.qml \
    CustomSlider.qml \
    OrbitCameraControllerBill.qml \
    PointsCloudEntity.qml \
    PointsCloudMaterial.qml \
    main.qml \
    pointsCloud.frag \
    pointsCloud.vert
