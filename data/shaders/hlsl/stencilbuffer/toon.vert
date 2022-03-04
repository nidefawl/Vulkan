// Copyright 2020 Google LLC

struct VSInput
{
[[vk::location(0)]] float3 Pos : POSITION0;
[[vk::location(1)]] float3 Color : COLOR0;
[[vk::location(2)]] float3 Normal : NORMAL0;
};

struct UBO
{
	float4x4 projection;
	float4x4 view;
	float4 lightPos;
};

cbuffer ubo : register(b0) { UBO ubo; }

struct VSOutput
{
	float4 Pos : SV_POSITION;
[[vk::location(0)]] float3 Normal : NORMAL0;
[[vk::location(1)]] float3 Color : COLOR0;
[[vk::location(2)]] float3 LightVec : TEXCOORD2;
};

VSOutput main(VSInput input)
{
	VSOutput output = (VSOutput)0;
	output.Color = float3(1.0, 0.0, 0.0);
	output.Pos = mul(ubo.projection, mul(ubo.view, float4(input.Pos.xyz, 1.0)));
	output.Normal = mul((float3x3)ubo.view, input.Normal);
	float4 pos = mul(ubo.view, float4(input.Pos, 1.0));
	float3 lPos = mul((float3x3)ubo.view, ubo.lightPos.xyz);
	output.LightVec = lPos - pos.xyz;
	return output;
}