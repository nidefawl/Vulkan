#version 450

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inColor;
layout (location = 2) in vec3 inNormal;

layout (binding = 0) uniform UBO 
{
	mat4 projection;
	mat4 view;
	mat4 model;
	vec4 lightPos;
} ubo;

layout(push_constant) uniform PushConsts {
	mat4 model;
} pushConsts;

layout (location = 0) out vec3 outNormal;
layout (location = 1) out vec3 outColor;
layout (location = 2) out vec3 outEyePos;
layout (location = 3) out vec3 outLightVec;

void main() 
{
	outNormal = inNormal;
	outColor = inColor;
	gl_Position = ubo.projection * ubo.view * pushConsts.model * vec4(inPos, 1.0);
	outEyePos = vec3(ubo.view * pushConsts.model * vec4(inPos, 1.0));
	outLightVec = normalize(ubo.lightPos.xyz - outEyePos);
}
