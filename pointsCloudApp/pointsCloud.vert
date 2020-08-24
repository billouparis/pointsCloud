/****************************************************************************
**
** Copyright (C) 2019 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
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
#version 330 core

in vec3 vertexPosition;
out vec3 worldPosition;
uniform float prBounce;
uniform mat4 modelMatrix;
uniform mat4 mvp;
//uniform int gl_VertexID;
//uniform float zArray[];

//uniform sampler1D myTexture1DArray;

//highp float rand(vec2 co);


void main()
{
    // Transform position, normal, and tangent to world coords
    worldPosition = vec3(modelMatrix * vec4(vertexPosition, 1.0));
    worldPosition.z = worldPosition.z * prBounce;
    // Calculate vertex position in clip coordinates
    gl_Position = mvp * vec4(worldPosition, 1.0);
}

//highp float rand(vec2 co)
//{
//    highp float a = 12.9898;
//    highp float b = 78.233;
//    highp float c = 43758.5453;
//    highp float dt= dot(co.xy , vec2(a,b));
//    highp float sn= mod(dt,3.14);
//    return fract(sin(sn) * c);
//}



//in vec3 attr_pos;
//uniform mat4 modelViewProjection;

//out vec3 pos;

//highp float rand(vec2 co);

//void main() {
//    pos = attr_pos;
////    pos.x += sin(time * 4.0 + pos.y) * amplitude;

//        pos.z = rand(vec2 (pos.x, pos.y)) * 100;
//        pos.z = 100.0;

//    gl_Position = modelViewProjection * vec4(pos, 1.0);
//}

//highp float rand(vec2 co)
//{
//    highp float a = 12.9898;
//    highp float b = 78.233;
//    highp float c = 43758.5453;
//    highp float dt= dot(co.xy , vec2(a,b));
//    highp float sn= mod(dt,3.14);
//    return fract(sin(sn) * c);
//}
