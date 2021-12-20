#version 330

uniform mat4 matVP;
uniform mat4 matGeo;

layout (location = 0) in vec3 pos;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 TexCoord;

out vec3 vNormal;
out vec3 vFragPos;
out vec2 vTextureCoord;

void main() {

   gl_Position = matVP * matGeo * vec4(pos, 1);
   
   mat3 normalMatrix = transpose(inverse(mat3(matGeo)));
   
   vFragPos = vec3(matGeo * vec4(pos, 1.0));   
   vTextureCoord = TexCoord;
   vNormal = mat3(transpose(inverse(matGeo))) * normal;
}