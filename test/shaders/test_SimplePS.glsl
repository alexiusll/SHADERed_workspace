#version 330

in vec4 color;
out vec4 outColor;

uniform vec4 uColor;
uniform float uTime;
uniform float uTest;


void main() {
   // outColor = vec4(color) * 0.9f;
   // return uColor;
   
   // -1 - 1 => 0 - 1
   float TimeFactor = ( sin(uTime) + 1 ) / 2;
   
   vec4 res = uColor * TimeFactor;
   
   outColor = vec4(res) + uTest;
}