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

import QtQuick 2.2 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.14
import QtQuick.Scene3D 2.14
import "."

//QQ2.Item {
//    width: 1900
//    height: 800
QQ2.Item {
    width: 1600
    height: 900

    CameraControls {
        id: idCameraControls
        prCamera: idCamera
        prFovInit: 45
        prPositionInit: Qt.vector3d( 0.5, 0.5, -10.0 )
        prUpVectorInit: Qt.vector3d( 0.0, 1.0, 0.0 )
        prViewCenterInit: Qt.vector3d( 0.5, 0.5, 0.0 )

    }


    Scene3D {
        id: idScene3D
        anchors.top: idCameraControls.bottom
        width: parent.width
        anchors.bottom: parent.bottom

        aspects: ["input", "logic"]
        focus: true
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio

        Entity {
            id: sceneRoot

            Camera {
                id: idCamera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 45
                aspectRatio: 16/9
                nearPlane : 1.0
                farPlane : -1.0
                position: Qt.vector3d( 0.5, 0.5, -10.0 )
                upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                viewCenter: Qt.vector3d( 0.5, 0.5, 0.0 )
//                onPositionChanged: console.log ("position" + position)
//                onUpVectorChanged: {
//                    console.log ("upVector" + upVector)
//                    // force upVector
//                    camera.upVector = Qt.vector3d( 0.0, 1.0, 0.0 )
//                }

//                onViewCenterChanged: console.log("viewCenter " + viewCenter)
//                onFieldOfViewChanged: console.log("FOV " + fieldOfView)
            }

            OrbitCameraController {
                camera: idCamera

            }

            components: [
                RenderSettings {
                    activeFrameGraph: ForwardRenderer {
                        clearColor: Qt.rgba(0, 0.1, 0.1, 1)
                        camera: idCamera
                        //showDebugOverlay: true
                        //viewportRect:  Qt.rect( 0, 0, 1920, 1080)
                        Viewport {
                            normalizedRect: Qt.rect(0.0, 0.0,
                                                    1.0, 1.0)
                            ClearBuffers {
                                buffers: ClearBuffers.ColorDepthBuffer
                            }
                        }
                    }
                },
                // Event Source will be set by the Qt3DQuickWindow
                InputSettings { }
            ]


            //////////////////////////////////////////////////////
            // PointsCloud custom Geometry
            PointsCloudEntity {

            }


        }

    }

    QQ2.Rectangle {
        x: idScene3D.width/2
        y: idScene3D.y
        width: 2
        height: idScene3D.height
        color: "green"


    }

    QQ2.Rectangle {
        x: idScene3D.x
        y: idScene3D.y + (idScene3D.height/2)
        height: 2
        width: idScene3D.width
        color: "green"

    }

}
//}
