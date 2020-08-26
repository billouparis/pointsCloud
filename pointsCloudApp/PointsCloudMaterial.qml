/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
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
import QtQuick 2.0 as QQ2
import Qt3D.Core 2.0
import Qt3D.Render 2.0

Material {
    id: idRoot


    property color maincolor: Qt.rgba(1.0, 0.0, 0.0, 1.0)

//    QQ2.Component.onCompleted: {
//        for (var i = 0; i < pointsCloud.zArray.length; i++)
//        {
//            console.log(pointsCloud.zArray[i])
//        }
//        console.log(pointsCloud.zArray.length + " " + pointsCloud.pointsCount)
//    }

    property real prBounce: 1.0

//    QQ2.SequentialAnimation {
//        running: idCameraControls.prBBounce
//        loops: QQ2.Animation.Infinite
//        QQ2.NumberAnimation {
//            target: idRoot
//            property: "prBounce"
//            duration: 2000
//            from: 0.0
//            to: 1.0
//            easing.type: Easing.OutBounce
//        }
//         QQ2.PauseAnimation {
//             duration: 1000
//         }

//        QQ2.NumberAnimation {
//            target: idRoot
//            property: "prBounce"
//            duration: 2000
//            from: 1.0
//            to: 0.0
//            easing.type: Easing.OutBounce
//        }
//    }
    //onPrBounceChanged: console.log(prBounce)


    parameters: [
        Parameter {
            name: "maincolor"
            value: Qt.vector3d(idRoot.maincolor.r, idRoot.maincolor.g, idRoot.maincolor.b)
        },
        Parameter {
            name: "prBounce"
            value: prBounce
        }

    ]


    effect: Effect {

        property string vertex: "pointsCloud.vert"
        property string fragment: "pointsCloud.frag"


        FilterKey {
            id: forward
            name: "renderingStyle"
            value: "forward"
        }

        ShaderProgram {
            id: gl3Shader
            vertexShaderCode: loadSource(Qt.resolvedUrl(parent.vertex))
            fragmentShaderCode: loadSource(Qt.resolvedUrl(parent.fragment))
        }


        techniques: [
            // OpenGL 3.3
            Technique {
                filterKeys: [forward]
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGL
                    profile: GraphicsApiFilter.CoreProfile
                    majorVersion: 3
                    minorVersion: 3
                }
                renderPasses: RenderPass {
                    shaderProgram: gl3Shader
                }
            }


        ]
    }


}
