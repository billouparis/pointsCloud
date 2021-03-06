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
    property real prAngle: 0
    property real prDistance
    property real prRotX
    property real prRotZ
    property alias prSystemCoord: idSystemCoord.checked

    Rectangle {
        anchors.fill: idRow
        color: "fuchsia"
    }

    Row {
        id: idRow

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

        CheckBox {
            id: idAnimRotation
            checked: false
            text: "Camera Rotation"
            onCheckedChanged: {
                console.log (checked)
                idAnim.running =  (checked == true)
                if (false == checked) {
                    prAngle = 0
                }
            }
        }

        CheckBox {
            id: idAnimRotation2
            checked: false
            text: "Camera Rotation"
            onCheckedChanged: {
                console.log (checked)
                idAnim.running =  (checked == true)
                if (false == checked) {
                    prAngle = 0
                }
            }
        }

        CheckBox {
            id: idSystemCoord
            checked: false
            text: "System Coord"

        }
    }

    onPrAngleChanged: {
        prRotX = Math.sin(idRoot.prAngle / 360. * Math.PI * 2) * prDistance
        prRotZ = Math.cos(idRoot.prAngle / 360. * Math.PI * 2) * prDistance

        if (idAnimRotation2.checked == true)
        {
            prCamera.setPosition(Qt.vector3d(0.0,
                                             prRotX,
                                             prRotZ))
        }
        else
        {
            prCamera.setPosition(Qt.vector3d(prRotX,
                                             0.0,
                                             prRotZ))
        }
    }

    SequentialAnimation {
        id: idAnim
        loops: Animation.Infinite
        NumberAnimation {
            target: idRoot
            property: "prAngle"
            from: 0
            to: 359
            duration: 3000
            easing.type: Easing.InOutQuad
        }
    }



}

