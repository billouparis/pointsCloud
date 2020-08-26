import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.14


Entity {
    id:     idRoot
    property real prDistance
    property Camera camera
    property real prAngle
    property real prRotX
    property real prRotZ


    MouseDevice {
        id: mouseDevice
        sensitivity: 0.001 // Make it smoother
    }

    MouseHandler {
        id: mh
        sourceDevice: mouseDevice

        property point lastPos;

        onPositionChanged: {
            fnDecreaseIncreaseAngle((mouse.x - lastPos.x) < 0)
            lastPos = Qt.point(mouse.x, mouse.y)
        }

        onWheel: {
            fnDecreaseIncreaseAngle(wheel.angleDelta.y > 0)
        }
    }

    function fnDecreaseIncreaseAngle(_decInc)
    {
        if (false === _decInc)
        {
            prAngle --
        }
        else
        {
            prAngle ++
        }
        prAngle = prAngle % 360

        prRotX = Math.sin(idRoot.prAngle / 360. * Math.PI * 2) * prDistance
        prRotZ = Math.cos(idRoot.prAngle / 360. * Math.PI * 2) * prDistance
        camera.setPosition(Qt.vector3d(prRotX,
                                       0.0,
                                       prRotZ))
    }
}
