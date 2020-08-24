/****************************************************************************
**
** Copyright (C) 2014 Klaralvdalens Datakonsult AB (KDAB).
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls 2.2
import Qt3D.Render 2.0

Item {
    id: idRoot
    width:  1600
    height: 150

    property Camera prCamera
    property real prFovInit: 45
    property variant prPositionInit: Qt.vector3d( 0.5, 0.5, -10.0 )
    property variant prUpVectorInit: Qt.vector3d( 0.0, 1.0, 0.0 )
    property variant prViewCenterInit: Qt.vector3d( 0.5, 0.5, 0.5 )

    property real prAngle: 0
    property real prDistance: 0
    property bool prBBounce: idBounce.checked
    property bool prBPoints: idBPoints.checked

    Rectangle {
        anchors.fill: parent
        color: "fuchsia"
    }

    onPrAngleChanged: {
        prCamera.setUpVector(prUpVectorInit)
        prCamera.setPosition(Qt.vector3d(Math.cos(idRoot.prAngle - Math.PI/2) * prDistance,
                    0.0,
                    Math.sin(idRoot.prAngle + Math.PI/2) * prDistance))
//console.log(Qt.vector3d(Math.cos(idRoot.prAngle - Math.M_PI/2) * -10.0,
//                        0.0,
//                        Math.sin(idRoot.prAngle - Math.M_PI/2) * -10.0))
        console.log(Math.cos(idRoot.prAngle - (Math.PI / 2)) * -10.0)
    }


    Row {
        Column {
            id: idCameraSettings

            Row {
                CustomSlider {
                    id: idFov
                    from: 0
                    to: 90
                    value: prCamera.fieldOfView
                    onValueChanged: {
                        console.log(value)
                        prCamera.setFieldOfView(value)
                    }
                    stepSize: 0.1
                    text: "FOV " + value
                    onSgnReset: prCamera.setFieldOfView(prFovInit)
                }


                CustomSlider {
                    id: idPosX
                    from: -10.0
                    to: 10.0
                    value: prCamera.position.x
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.position.x = value
                    }
                    stepSize: 0.01
                    text: "PosX " + value
                    onSgnReset:   prCamera.setPosition(Qt.vector3d(prPositionInit.x, idPosY.value, idPosZ.value))

                }

                CustomSlider {
                    id: idPosY
                    from: -10.0
                    to: 10.0
                    value: prCamera.position.y
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.position.y = value

                    }
                    stepSize: 0.01
                    text: "PosY " + value
                    onSgnReset:  prCamera.setPosition(Qt.vector3d(idPosX.value, prPositionInit.y, idPosZ.value))

                }

                CustomSlider {
                    id: idPosZ
                    from: -10.0
                    to: 10.0
                    value: prCamera.position.z
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.position.z = value
                    }
                    stepSize: 0.01
                    text: "PosZ " + value
                    onSgnReset: prCamera.setPosition(Qt.vector3d(idPosX.value, idPosY.value, prPositionInit.z))

                }
            }

            Row {
                CustomSlider {
                    id: idUpX
                    from: -1.0
                    to: 1.0
                    value: prCamera.upVector.x
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.upVector.x = value
                    }
                    stepSize: 0.01
                    text: "UpX " + value
                    onSgnReset: prCamera.setUpVector(Qt.vector3d(prUpVectorInit.x, idUpY.value, idUpZ.value))


                }

                CustomSlider {
                    id: idUpY
                    from: -1.0
                    to: 1.0
                    value: prCamera.upVector.y
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.upVector.y = value
                    }
                    stepSize: 0.01
                    text: "UpY " + value
                    onSgnReset: prCamera.setUpVector(Qt.vector3d(idUpX.value, prUpVectorInit.y, idUpZ.value))

                }

                CustomSlider {
                    id: idUpZ
                    from: -1.0
                    to: 1.0
                    value: prCamera.upVector.z
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.upVector.z = value
                    }
                    stepSize: 0.01
                    text: "UpZ " + value
                    onSgnReset: prCamera.setUpVector(Qt.vector3d(idUpX.value, idUpY.value, prUpVectorInit.z))


                }
            }


        }


        Column {

            Row {
                CustomSlider {
                    id: idVcX
                    from: -1.0
                    to: 1.0
                    value: prCamera.viewCenter.x
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.viewCenter.x = value
                    }
                    stepSize: 0.01
                    text: "UpX " + value
                    onSgnReset: prCamera.setViewCenter(Qt.vector3d(prViewCenterInit.x, idVcY.value, idVcZ.value))


                }

                CustomSlider {
                    id: idVcY
                    from: -1.0
                    to: 1.0
                    value: prCamera.viewCenter.y
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.viewCenter.y = value
                    }
                    stepSize: 0.01
                    text: "UpY " + value
                    onSgnReset: prCamera.setViewCenter(Qt.vector3d(idVcX.value, prViewCenterInit.y, idVcZ.value))

                }

                CustomSlider {
                    id: idVcZ
                    from: -1.0
                    to: 1.0
                    value: prCamera.viewCenter.z
                    onValueChanged: {
                        console.log(value)
                        if (idAnim.running == false) prCamera.viewCenter.z = value
                    }
                    stepSize: 0.01
                    text: "UpZ " + value
                    onSgnReset: prCamera.setViewCenter(Qt.vector3d(idVcX.value, idVcY.value, prViewCenterInit.z))


                }
            }

            Row {

                CheckBox {
                    id: idAnimCB
                    checked: false
                    text: "Camera Animation"
                    onCheckedChanged: {
                        console.log (checked)
                        prDistance = idPosZ.value
                            idAnim.running =  (checked == true)

                    }
                }




                CheckBox {
                    id: idBounce
                    checked: false
                    text: "Shape Bounce Animation"
                }

                CheckBox {
                    id: idBPoints
                    checked: false
                    text: "Points Triangles"
                }

            }

        }


    }

    SequentialAnimation {
        id: idAnim

        NumberAnimation {
            target: idRoot
            property: "prAngle"
            from: 0
            to: 2 * Math.PI
            duration: 10000
            easing.type: Easing.InOutQuad
        }
    }



}

