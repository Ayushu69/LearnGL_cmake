#version 330 core
layout (location = 0) in vec3 aPos;

out vec3 ourColor;

uniform float xOffset;

void main()
{
    gl_Position = vec4(aPos.x + xOffset, aPos.y, aPos.z, 1.0);
    ourColor = aPos;
}