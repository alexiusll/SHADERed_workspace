#version 330

in vec4 color;
out vec4 outColor;

uniform sampler2D uSampler;

// --- texture ---
// has a texture?
uniform int uTextureSample;
// color
uniform vec3 defaultColor;

// for light render
uniform vec3 uLightPos;
uniform vec3 uCameraPos;
uniform vec3 uLightIntensity;

// in from vs
in vec2 vTextureCoord;
in vec3 vFragPos;
in vec3 vNormal;

float near = 0.1; 
float far  = 100.0; 

float LinearizeDepth(float depth) 
{
    float z = depth * 2.0 - 1.0; // back to NDC 
    return (2.0 * near * far) / (far + near - z * (far - near));    
}

void main() {
	vec3 color;
	if (uTextureSample == 1) {
		color = texture(uSampler, vTextureCoord).rgb;
		color = pow(color, vec3(2.2));
	} else {
		color = defaultColor;
	}
	
	vec3 ambient = 0.05 * color;

	// diffuse
	vec3 normal = normalize(vNormal);
	vec3 lightDir = normalize(uLightPos - vFragPos);
	float diff = max(dot(lightDir, normal), 0.0);
	vec3 diffuse = diff * color;
	
	// specular
    float specularStrength = 1.0;
    vec3 viewDir = normalize(uCameraPos - vFragPos);
    vec3 reflectDir = reflect(-lightDir, normal);  
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    
    vec3 specular = specularStrength * spec * color;
	
	vec3 radiance = (ambient + diffuse + specular);
	vec3 phongColor = pow(radiance, vec3(1.0 / 2.2));
	
	// outColor = vec4(phongColor, 1.0);
	
	
	
	// z buffer
	float depth = LinearizeDepth(gl_FragCoord.z) / far; 
    outColor = vec4(vec3(depth), 1.0); 
} 