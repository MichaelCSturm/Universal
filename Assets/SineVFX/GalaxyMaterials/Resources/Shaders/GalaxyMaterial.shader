// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/GalaxyMaterials/GalaxyMaterial"
{
	Properties
	{
		_FinalPower("Final Power", Float) = 4
		_NormalTexture("Normal Texture", 2D) = "bump" {}
		_NormalAmount("Normal Amount", Range( 0 , 1)) = 1
		[Toggle(_RIMENABLED_ON)] _RimEnabled("Rim Enabled", Float) = 1
		_RimAddOrMultiply("Rim Add Or Multiply", Range( 0 , 1)) = 0
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_RimEmissionPower("Rim Emission Power", Float) = 1
		_RimExp("Rim Exp", Range( 0.2 , 10)) = 4
		_RimExp2("Rim Exp 2", Range( 0.2 , 10)) = 2
		_RimNoiseTexture("Rim Noise Texture", 2D) = "white" {}
		_RimNoiseTilingU("Rim Noise Tiling U", Float) = 1
		_RimNoiseTilingV("Rim Noise Tiling V", Float) = 1
		_RimNoiseAmount("Rim Noise Amount", Float) = -2.5
		_RimNoiseRefraction("Rim Noise Refraction", Range( 0 , 1)) = 0
		_RimNoiseScrollSpeed("Rim Noise Scroll Speed", Float) = 0.1
		_RimNoiseTwistAmount("Rim Noise Twist Amount", Range( 0 , 2)) = 0
		[Toggle(_RIMNOISECAENABLED_ON)] _RimNoiseCAEnabled("Rim Noise CA Enabled", Float) = 0
		_RimNoiseCAAmount("Rim Noise CA Amount", Range( 0 , 0.1)) = 0.1
		_RimNoiseCAU("Rim Noise CA U", Range( 0 , 1)) = 1
		_RimNoiseCAV("Rim Noise CA V", Range( 0 , 1)) = 0
		_RimNoiseCARimMaskExp("Rim Noise CA Rim Mask Exp", Range( 0.2 , 8)) = 4
		_RimNoiseDistortionTexture("Rim Noise Distortion Texture", 2D) = "white" {}
		_RimNoiseDistortionTilingU("Rim Noise Distortion Tiling U", Float) = 2
		_RimNoiseDistortionTilingV("Rim Noise Distortion Tiling V", Float) = 4
		_RimNoiseDistortionAmount("Rim Noise Distortion Amount", Float) = 0
		_RimNoiseSpherize("Rim Noise Spherize", Range( 0 , 1)) = 0
		_RimNoiseSpherizePosition("Rim Noise Spherize Position", Vector) = (0,0,0,0)
		_Eta("Eta", Range( -1 , 0)) = -0.1
		_EtaFresnelExp("Eta Fresnel Exp", Range( 1 , 8)) = 3
		_EtaFresnelExp2("Eta Fresnel Exp 2", Range( 1 , 8)) = 1
		_EtaAAEdgesFix("Eta AA Edges Fix", Range( 0 , 0.5)) = 0
		_RotationAxis("Rotation Axis", Vector) = (0,1,0,0)
		_RotationStars("Rotation Stars", Float) = 0
		_RotationClouds("Rotation Clouds", Float) = 0
		_RotationDarkClouds("Rotation Dark Clouds", Float) = 0
		_StarsTexture("Stars Texture", CUBE) = "white" {}
		_StarsEmissionPower("Stars Emission Power", Float) = 4
		_StarsRotationSpeed("Stars Rotation Speed", Float) = 0.1
		_StarsExp("Stars Exp", Range( 0.2 , 8)) = 1
		_StarsExpNegate("Stars Exp Negate", Range( 0 , 1)) = 1
		_StarsColorTint("Stars Color Tint", Color) = (1,1,1,1)
		_CloudsTexture("Clouds Texture", CUBE) = "black" {}
		_CloudsOpacityPower("Clouds Opacity Power", Float) = 1
		_CloudsOpacityExp("Clouds Opacity Exp", Range( 0.2 , 4)) = 1
		_CloudsEmissionPower("Clouds Emission Power", Float) = 1
		_CloudsRotationSpeed("Clouds Rotation Speed", Float) = 0.1
		_CloudsRamp("Clouds Ramp", 2D) = "white" {}
		_CloudsRampColorTint("Clouds Ramp Color Tint", Color) = (1,1,1,1)
		_CloudsRampOffsetExp("Clouds Ramp Offset Exp", Range( 0.2 , 8)) = 1
		_CloudsRampOffsetExp2("Clouds Ramp Offset Exp 2", Range( 0.2 , 8)) = 1
		[Toggle(_DARKCLOUDSENABLED_ON)] _DarkCloudsEnabled("Dark Clouds Enabled", Float) = 0
		_DarkCloudsTexture("Dark Clouds Texture", CUBE) = "white" {}
		_DarkCloudsLighten("Dark Clouds Lighten", Range( 1 , 10)) = 1
		_DarkCloudsThicker("Dark Clouds Thicker", Range( 0.2 , 4)) = 1
		_DarkCloudsRotationSpeed("Dark Clouds Rotation Speed", Float) = 0.1
		[Toggle]_DarkCloudsEdgesGlowStyle("Dark Clouds Edges Glow Style", Float) = 0
		_DarkCloudsEdgesGlowPower("Dark Clouds Edges Glow Power", Float) = 50
		_DarkCloudsEdgesGlowExp("Dark Clouds Edges Glow Exp", Range( 0.2 , 4)) = 1
		_DarkCloudsEdgesGlowClamp("Dark Clouds Edges Glow Clamp", Range( 1 , 4)) = 2
		_FOWFix("FOW Fix", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _DARKCLOUDSENABLED_ON
		#pragma shader_feature _RIMENABLED_ON
		#pragma shader_feature _RIMNOISECAENABLED_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform float _FinalPower;
		uniform samplerCUBE _StarsTexture;
		uniform float3 _RotationAxis;
		uniform float _StarsRotationSpeed;
		uniform float _RotationStars;
		uniform float _FOWFix;
		uniform sampler2D _NormalTexture;
		uniform float4 _NormalTexture_ST;
		uniform float _NormalAmount;
		uniform float _Eta;
		uniform float _EtaFresnelExp;
		uniform float _EtaFresnelExp2;
		uniform sampler2D _RimNoiseTexture;
		uniform float _RimNoiseTwistAmount;
		uniform float _RimNoiseTilingV;
		uniform float4 _RimNoiseSpherizePosition;
		uniform float _RimNoiseSpherize;
		uniform float _RimNoiseTilingU;
		uniform float _RimNoiseScrollSpeed;
		uniform sampler2D _RimNoiseDistortionTexture;
		uniform float _RimNoiseDistortionTilingU;
		uniform float _RimNoiseDistortionTilingV;
		uniform float _RimNoiseDistortionAmount;
		uniform float _RimNoiseAmount;
		uniform float _RimExp;
		uniform float _RimExp2;
		uniform float _RimNoiseRefraction;
		uniform float _EtaAAEdgesFix;
		uniform float _StarsExp;
		uniform float _StarsExpNegate;
		uniform float4 _StarsColorTint;
		uniform float _StarsEmissionPower;
		uniform float _RimNoiseCAU;
		uniform float _RimNoiseCAAmount;
		uniform float _RimNoiseCARimMaskExp;
		uniform float _RimNoiseCAV;
		uniform float _RimEmissionPower;
		uniform float4 _RimColor;
		uniform float _RimAddOrMultiply;
		uniform sampler2D _CloudsRamp;
		uniform samplerCUBE _CloudsTexture;
		uniform float _CloudsRotationSpeed;
		uniform float _RotationClouds;
		uniform float _CloudsRampOffsetExp;
		uniform float _CloudsRampOffsetExp2;
		uniform float _CloudsEmissionPower;
		uniform float4 _CloudsRampColorTint;
		uniform float _CloudsOpacityExp;
		uniform float _CloudsOpacityPower;
		uniform float _DarkCloudsEdgesGlowStyle;
		uniform samplerCUBE _DarkCloudsTexture;
		uniform float _DarkCloudsRotationSpeed;
		uniform float _RotationDarkClouds;
		uniform float _DarkCloudsEdgesGlowExp;
		uniform float _DarkCloudsEdgesGlowPower;
		uniform float _DarkCloudsEdgesGlowClamp;
		uniform float _DarkCloudsThicker;
		uniform float _DarkCloudsLighten;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		float3 RefractFixed797( float3 V, float3 N, float Eta, float In0 )
		{
			//float d = clamp(dot(N, V) + In0, -1, 0);
			float d = abs(dot(N, V) + In0) * -1;
			float k = 1.0 - Eta * Eta * (1.0 - d * d);
			float3 R = Eta * V - (Eta * d + sqrt(k)) * N;
			return R;
		}


		float3 RefractFixed795( float3 V, float3 N, float Eta, float In0 )
		{
			//float d = clamp(dot(N, V) + In0, -1, 0);
			float d = abs(dot(N, V) + In0) * -1;
			float k = 1.0 - Eta * Eta * (1.0 - d * d);
			float3 R = Eta * V - (Eta * d + sqrt(k)) * N;
			return R;
		}


		float3 RefractFixed796( float3 V, float3 N, float Eta, float In0 )
		{
			//float d = clamp(dot(N, V) + In0, -1, 0);
			float d = abs(dot(N, V) + In0) * -1;
			float k = 1.0 - Eta * Eta * (1.0 - d * d);
			float3 R = Eta * V - (Eta * d + sqrt(k)) * N;
			return R;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float temp_output_1023_0 = ( ( _Time.y * _StarsRotationSpeed ) + _RotationStars );
			float3 viewToWorldDir1047 = mul( UNITY_MATRIX_I_V, float4( float3(0,0,1), 0 ) ).xyz;
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult1055 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float3 normalizeResult1059 = normalize( ( ( viewToWorldDir1047 * _FOWFix ) + normalizeResult1055 ) );
			float3 rotatedValue646 = RotateAroundAxis( float3( 0,0,0 ), -normalizeResult1059, normalize( _RotationAxis ), temp_output_1023_0 );
			float3 V797 = rotatedValue646;
			float2 uv_NormalTexture = i.uv_texcoord * _NormalTexture_ST.xy + _NormalTexture_ST.zw;
			float3 lerpResult929 = lerp( float3(0,0,1) , UnpackNormal( tex2D( _NormalTexture, uv_NormalTexture ) ) , _NormalAmount);
			float3 newWorldNormal402 = (WorldNormalVector( i , lerpResult929 ));
			float3 rotatedValue652 = RotateAroundAxis( float3( 0,0,0 ), newWorldNormal402, normalize( _RotationAxis ), temp_output_1023_0 );
			float3 N797 = rotatedValue652;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV642 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode642 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV642, _EtaFresnelExp ) );
			float clampResult799 = clamp( fresnelNode642 , 0.0 , 1.0 );
			float clampResult881 = clamp( ( 1.0 - pow( ( 1.0 - clampResult799 ) , _EtaFresnelExp2 ) ) , 0.0 , 1.0 );
			float fresnelNdotV601 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode601 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV601, 1.0 ) );
			float temp_output_190_0 = ( _RimNoiseTwistAmount * fresnelNode601 * _RimNoiseTilingV );
			float3 appendResult997 = (float3(_RimNoiseSpherizePosition.x , _RimNoiseSpherizePosition.y , _RimNoiseSpherizePosition.z));
			float3 objToWorld606 = mul( unity_ObjectToWorld, float4( appendResult997, 1 ) ).xyz;
			float3 normalizeResult499 = normalize( ( ase_worldPos - objToWorld606 ) );
			float3 lerpResult602 = lerp( ase_worldNormal , normalizeResult499 , _RimNoiseSpherize);
			float3 worldToViewDir153 = mul( UNITY_MATRIX_V, float4( lerpResult602, 0 ) ).xyz;
			float temp_output_173_0 = (0.0 + (atan2( worldToViewDir153.x , worldToViewDir153.y ) - ( -1.0 * UNITY_PI )) * (1.0 - 0.0) / (UNITY_PI - ( -1.0 * UNITY_PI )));
			float temp_output_927_0 = (0.0 + (max( ( 1.0 - temp_output_173_0 ) , temp_output_173_0 ) - 0.5) * (1.0 - 0.0) / (1.0 - 0.5));
			float temp_output_494_0 = ( temp_output_927_0 * _RimNoiseTilingV );
			float temp_output_178_0 = ( ( fresnelNode601 * _RimNoiseTilingU ) + ( _Time.y * _RimNoiseScrollSpeed ) );
			float2 appendResult177 = (float2(( temp_output_190_0 + temp_output_494_0 ) , temp_output_178_0));
			float3 worldToViewDir4 = mul( UNITY_MATRIX_V, float4( newWorldNormal402, 0 ) ).xyz;
			float2 appendResult939 = (float2(_RimNoiseDistortionTilingU , _RimNoiseDistortionTilingV));
			float2 appendResult920 = (float2(temp_output_927_0 , temp_output_178_0));
			float fresnelNdotV948 = dot( newWorldNormal402, ase_worldViewDir );
			float fresnelNode948 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV948, 1.0 ) );
			float3 temp_output_913_0 = ( worldToViewDir4 * tex2D( _RimNoiseDistortionTexture, ( appendResult939 * appendResult920 ) ).r * _RimNoiseDistortionAmount * fresnelNode948 );
			float3 lerpResult98 = lerp( newWorldNormal402 , normalizeResult1059 , ( tex2D( _RimNoiseTexture, ( float3( appendResult177 ,  0.0 ) + temp_output_913_0 ).xy ).r * _RimNoiseAmount ));
			float3 normalizeResult102 = normalize( lerpResult98 );
			float fresnelNdotV17 = dot( normalizeResult102, ase_worldViewDir );
			float fresnelNode17 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV17, 1.0 ) );
			float clampResult119 = clamp( pow( fresnelNode17 , _RimExp ) , 0.0 , 1.0 );
			float temp_output_78_0 = ( 1.0 - pow( ( 1.0 - clampResult119 ) , _RimExp2 ) );
			float temp_output_645_0 = ( 1.0 + ( _Eta * clampResult881 ) + ( temp_output_78_0 * -_RimNoiseRefraction ) );
			float Eta797 = temp_output_645_0;
			float In0797 = _EtaAAEdgesFix;
			float3 localRefractFixed797 = RefractFixed797( V797 , N797 , Eta797 , In0797 );
			float4 texCUBENode640 = texCUBE( _StarsTexture, localRefractFixed797 );
			float3 desaturateInitialColor1037 = texCUBENode640.rgb;
			float desaturateDot1037 = dot( desaturateInitialColor1037, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar1037 = lerp( desaturateInitialColor1037, desaturateDot1037.xxx, 1.0 );
			float3 temp_cast_3 = (_StarsExp).xxx;
			float3 clampResult1042 = clamp( ( pow( desaturateVar1037 , temp_cast_3 ) + _StarsExpNegate ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float4 temp_output_1044_0 = ( float4( clampResult1042 , 0.0 ) * texCUBENode640 * _StarsColorTint );
			float4 temp_cast_5 = (0.0).xxxx;
			float3 temp_cast_6 = (temp_output_78_0).xxx;
			float fresnelNdotV952 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode952 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV952, _RimNoiseCARimMaskExp ) );
			float temp_output_504_0 = ( _RimNoiseCAU * _RimNoiseCAAmount * fresnelNode952 );
			float temp_output_505_0 = ( _RimNoiseCAAmount * _RimNoiseCAV * fresnelNode952 );
			float temp_output_507_0 = ( temp_output_178_0 + temp_output_505_0 );
			float2 appendResult210 = (float2(( temp_output_190_0 + temp_output_494_0 + temp_output_504_0 ) , temp_output_507_0));
			float3 lerpResult224 = lerp( newWorldNormal402 , normalizeResult1059 , ( tex2D( _RimNoiseTexture, ( float3( appendResult210 ,  0.0 ) + temp_output_913_0 ).xy ).r * _RimNoiseAmount ));
			float3 normalizeResult228 = normalize( lerpResult224 );
			float fresnelNdotV230 = dot( normalizeResult228, ase_worldViewDir );
			float fresnelNode230 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV230, 1.0 ) );
			float clampResult234 = clamp( pow( fresnelNode230 , _RimExp ) , 0.0 , 1.0 );
			float2 appendResult211 = (float2(( temp_output_190_0 + temp_output_494_0 + ( temp_output_504_0 * 2.0 ) ) , ( temp_output_507_0 + ( temp_output_505_0 * 2.0 ) )));
			float3 lerpResult227 = lerp( newWorldNormal402 , normalizeResult1059 , ( tex2D( _RimNoiseTexture, ( float3( appendResult211 ,  0.0 ) + temp_output_913_0 ).xy ).r * _RimNoiseAmount ));
			float3 normalizeResult229 = normalize( lerpResult227 );
			float fresnelNdotV231 = dot( normalizeResult229, ase_worldViewDir );
			float fresnelNode231 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV231, 1.0 ) );
			float clampResult240 = clamp( pow( fresnelNode231 , _RimExp ) , 0.0 , 1.0 );
			float3 appendResult245 = (float3(temp_output_78_0 , ( 1.0 - pow( ( 1.0 - clampResult234 ) , _RimExp2 ) ) , ( 1.0 - pow( ( 1.0 - clampResult240 ) , _RimExp2 ) )));
			#ifdef _RIMNOISECAENABLED_ON
				float3 staticSwitch1013 = appendResult245;
			#else
				float3 staticSwitch1013 = temp_cast_6;
			#endif
			#ifdef _RIMENABLED_ON
				float4 staticSwitch1009 = ( float4( staticSwitch1013 , 0.0 ) * _RimEmissionPower * _RimColor );
			#else
				float4 staticSwitch1009 = temp_cast_5;
			#endif
			float lerpResult841 = lerp( 0.0 , 1.0 , _RimAddOrMultiply);
			float4 temp_output_846_0 = ( ( staticSwitch1009 * lerpResult841 ) + 1.0 );
			float temp_output_1024_0 = ( ( _Time.y * _CloudsRotationSpeed ) + _RotationClouds );
			float3 rotatedValue684 = RotateAroundAxis( float3( 0,0,0 ), -normalizeResult1059, normalize( _RotationAxis ), temp_output_1024_0 );
			float3 V795 = rotatedValue684;
			float3 rotatedValue685 = RotateAroundAxis( float3( 0,0,0 ), newWorldNormal402, normalize( _RotationAxis ), temp_output_1024_0 );
			float3 N795 = rotatedValue685;
			float Eta795 = temp_output_645_0;
			float In0795 = _EtaAAEdgesFix;
			float3 localRefractFixed795 = RefractFixed795( V795 , N795 , Eta795 , In0795 );
			float4 texCUBENode674 = texCUBE( _CloudsTexture, localRefractFixed795 );
			float clampResult744 = clamp( pow( texCUBENode674.r , _CloudsRampOffsetExp ) , 0.0 , 1.0 );
			float2 appendResult720 = (float2(( 1.0 - pow( ( 1.0 - clampResult744 ) , _CloudsRampOffsetExp2 ) ) , 0.0));
			float4 tex2DNode719 = tex2D( _CloudsRamp, appendResult720 );
			float clampResult733 = clamp( ( pow( texCUBENode674.r , _CloudsOpacityExp ) * _CloudsOpacityPower ) , 0.0 , 1.0 );
			float4 lerpResult871 = lerp( ( temp_output_1044_0 * _StarsEmissionPower * temp_output_846_0 ) , ( tex2DNode719 * _CloudsEmissionPower * _CloudsRampColorTint * temp_output_846_0 ) , clampResult733);
			float4 temp_cast_12 = (0.0).xxxx;
			float temp_output_1025_0 = ( ( _Time.y * _DarkCloudsRotationSpeed ) + _RotationDarkClouds );
			float3 rotatedValue686 = RotateAroundAxis( float3( 0,0,0 ), -normalizeResult1059, normalize( _RotationAxis ), temp_output_1025_0 );
			float3 V796 = rotatedValue686;
			float3 rotatedValue687 = RotateAroundAxis( float3( 0,0,0 ), newWorldNormal402, normalize( _RotationAxis ), temp_output_1025_0 );
			float3 N796 = rotatedValue687;
			float Eta796 = temp_output_645_0;
			float In0796 = _EtaAAEdgesFix;
			float3 localRefractFixed796 = RefractFixed796( V796 , N796 , Eta796 , In0796 );
			float4 texCUBENode779 = texCUBE( _DarkCloudsTexture, localRefractFixed796 );
			float clampResult787 = clamp( ( ( pow( (( _DarkCloudsEdgesGlowStyle )?( texCUBENode779.b ):( texCUBENode779.g )) , _DarkCloudsEdgesGlowExp ) * _DarkCloudsEdgesGlowPower ) + 1.0 ) , 0.0 , _DarkCloudsEdgesGlowClamp );
			float4 lerpResult740 = lerp( ( temp_output_1044_0 * _StarsEmissionPower * clampResult787 * temp_output_846_0 ) , ( tex2DNode719 * _CloudsEmissionPower * _CloudsRampColorTint * clampResult787 * temp_output_846_0 ) , clampResult733);
			float clampResult773 = clamp( ( pow( texCUBENode779.r , _DarkCloudsThicker ) * _DarkCloudsLighten ) , 0.0 , 1.0 );
			float4 lerpResult745 = lerp( temp_cast_12 , lerpResult740 , clampResult773);
			#ifdef _DARKCLOUDSENABLED_ON
				float4 staticSwitch868 = lerpResult745;
			#else
				float4 staticSwitch868 = lerpResult871;
			#endif
			o.Emission = ( ( _FinalPower * staticSwitch868 ) + ( staticSwitch1009 * ( 1.0 - lerpResult841 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.CommentaryNode;993;-9264.999,4946.896;Inherit;False;9716.596;3029.238;;100;607;604;606;605;499;603;497;602;153;172;174;175;173;928;183;601;181;179;180;182;178;937;938;920;939;495;191;916;190;494;189;914;948;923;953;177;913;215;952;502;501;192;910;504;505;100;193;101;99;216;507;506;98;212;213;508;210;211;102;912;17;911;19;132;218;217;220;223;226;221;119;21;18;224;227;873;228;229;20;230;231;239;233;234;240;235;241;242;236;237;243;245;82;83;80;949;950;996;997;1013;Rim;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;996;-9242.062,6323.364;Inherit;False;Property;_RimNoiseSpherizePosition;Rim Noise Spherize Position;26;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;997;-8964.062,6345.364;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformPositionNode;606;-9044.527,6026.902;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;604;-9011.75,5877.21;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;605;-8776.25,5957.109;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;499;-8627.604,5959.38;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;603;-8738.044,6062.789;Float;False;Property;_RimNoiseSpherize;Rim Noise Spherize;25;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;497;-8646.713,5804.223;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;602;-8425.644,5880.789;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformDirectionNode;153;-8247.838,5851.666;Inherit;False;World;View;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ATan2OpNode;172;-7998.426,5868.808;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;174;-7970.926,6083.706;Inherit;False;1;0;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;175;-7973.728,6146.706;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;173;-7709.322,5916.24;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;928;-7342.048,5816.791;Inherit;False;681.0513;318.8217;;3;927;926;925;Mipmap fix but mirrored;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;179;-5969.416,7077.641;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;183;-6167.431,6979.722;Float;False;Property;_RimNoiseTilingU;Rim Noise Tiling U;10;0;Create;True;0;0;0;False;0;False;1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;601;-6189.337,6798.014;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;-6009.507,7220.804;Float;False;Property;_RimNoiseScrollSpeed;Rim Noise Scroll Speed;14;0;Create;True;0;0;0;False;0;False;0.1;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;925;-7292.048,5866.791;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-5745.189,7147.081;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;933;-7880.236,1531.325;Inherit;False;940.1934;520;;5;931;930;401;929;402;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;926;-7112.861,5909.249;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;-5698.024,6871.57;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;938;-6610.99,5125.67;Inherit;False;Property;_RimNoiseDistortionTilingV;Rim Noise Distortion Tiling V;23;0;Create;True;0;0;0;False;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;927;-6940.044,5887.263;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;178;-5488.375,6874.852;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;931;-7816.522,1936.325;Inherit;False;Property;_NormalAmount;Normal Amount;2;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;930;-7708.522,1581.325;Inherit;False;Constant;_Vector1;Vector 1;58;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;401;-7830.236,1732.249;Inherit;True;Property;_NormalTexture;Normal Texture;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;937;-6612.99,5049.077;Inherit;False;Property;_RimNoiseDistortionTilingU;Rim Noise Distortion Tiling U;22;0;Create;True;0;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;929;-7384.522,1740.325;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;939;-6294.695,5075.745;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-6062.927,6344.022;Float;False;Property;_RimNoiseTwistAmount;Rim Noise Twist Amount;15;0;Create;True;0;0;0;False;0;False;0;0.25;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;495;-6170.885,6707.987;Float;False;Property;_RimNoiseTilingV;Rim Noise Tiling V;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;920;-6289.066,5234.227;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;402;-7157.043,1656.952;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;916;-6069.023,5145.657;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;190;-5695.808,6439.314;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;494;-5699.21,6656.878;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;948;-5839.254,5407.133;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;4;-6791.538,1281.359;Inherit;False;World;View;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;923;-5899.122,5318.927;Inherit;False;Property;_RimNoiseDistortionAmount;Rim Noise Distortion Amount;24;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;189;-5480.558,6524.509;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;914;-5907.772,5106.723;Inherit;True;Property;_RimNoiseDistortionTexture;Rim Noise Distortion Texture;21;0;Create;True;0;0;0;False;0;False;-1;None;7d5f6337ffe5dfa4c99c39298646caae;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;953;-6201.625,7852.597;Inherit;False;Property;_RimNoiseCARimMaskExp;Rim Noise CA Rim Mask Exp;20;0;Create;True;0;0;0;False;0;False;4;4;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;913;-5514.507,5230.34;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;177;-5324.322,6679.452;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FresnelNode;952;-5883.246,7774.134;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;501;-5931.965,7418.017;Float;False;Property;_RimNoiseCAU;Rim Noise CA U;18;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;910;-4658.474,5312.627;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;502;-5928.866,7615.614;Float;False;Property;_RimNoiseCAV;Rim Noise CA V;19;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;215;-5934.692,7519.963;Float;False;Property;_RimNoiseCAAmount;Rim Noise CA Amount;17;0;Create;True;0;0;0;False;0;False;0.1;0.05;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;192;-4272.599,5519.302;Float;True;Property;_RimNoiseTexture;Rim Noise Texture;9;0;Create;True;0;0;0;False;0;False;None;57535fb8629b4c6eb8530d7d3664d59f;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;504;-5648.14,7439.099;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;193;-3908.738,5369.989;Inherit;True;Property;_TextureSample3;Texture Sample 3;17;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;505;-5635.473,7562.178;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-3904.398,5577.17;Float;False;Property;_RimNoiseAmount;Rim Noise Amount;12;0;Create;True;0;0;0;False;0;False;-2.5;0.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;99;-3831.497,5210.378;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;506;-5416.372,7555.077;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-3586.616,5464.215;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;507;-5183.767,6906.481;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;-5419.066,7427.848;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;212;-5122.629,6512.069;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;213;-4867.962,6622.232;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;508;-4873.104,7013.485;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1008;-4249.113,2852.309;Inherit;False;1683.029;661.7981;;13;664;642;799;878;879;877;880;881;636;643;644;645;848;Eta (Main Background);1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;98;-3497.712,5069.445;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;210;-5034.01,6713.172;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;211;-4716.931,6847.198;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;664;-4199.113,3392.238;Float;False;Property;_EtaFresnelExp;Eta Fresnel Exp;28;0;Create;True;0;0;0;False;0;False;3;3;1;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;102;-3340.712,5068.162;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;911;-4658.804,5534.522;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;17;-2148.446,5069.102;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;642;-3926.252,3224.001;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1817.901,5453.42;Float;False;Property;_RimExp;Rim Exp;7;0;Create;True;0;0;0;False;0;False;4;4;0.2;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;912;-4600.222,5829.18;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;217;-3903.503,5670.066;Inherit;True;Property;_TextureSample5;Texture Sample 5;20;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;218;-3903.225,5890.437;Inherit;True;Property;_TextureSample6;Texture Sample 6;21;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;132;-1350.275,5032.594;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;799;-3689.354,3224.873;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-3575.35,5685.34;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;226;-3056.196,6251.766;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;223;-3248.518,5499.892;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;879;-3543.71,3224.658;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;-3577.765,5890.653;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;119;-1135.883,5040.975;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;878;-3684.508,3399.107;Inherit;False;Property;_EtaFresnelExp2;Eta Fresnel Exp 2;29;0;Create;True;0;0;0;False;0;False;1;1;1;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1015;-3512.091,386.7835;Inherit;False;4285.613;2206.039;;69;868;795;804;674;744;797;720;742;734;640;722;735;719;741;733;721;870;740;869;871;803;723;745;772;681;638;654;680;683;682;648;639;687;686;685;684;656;655;652;646;779;777;693;776;692;773;789;1007;785;790;786;784;783;787;788;796;1016;1017;1018;1019;1020;1021;1023;1025;1024;1026;1027;1028;637;Main Background;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;227;-2811.883,6137.678;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;18;-966.4468,5041.777;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;877;-3381.861,3224.191;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;994;-3504.216,3730.325;Inherit;False;682;269;;3;991;992;990;Rim Noise Refraction;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;224;-3004.201,5554.304;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1131.708,5459.942;Float;False;Property;_RimExp2;Rim Exp 2;8;0;Create;True;0;0;0;False;0;False;2;2;0.2;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;654;-3381.171,1622.695;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;20;-751.5173,5044.682;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;880;-3231.991,3227.186;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;991;-3454.216,3884.325;Inherit;False;Property;_RimNoiseRefraction;Rim Noise Refraction;13;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;680;-3427.988,1851.461;Float;False;Property;_CloudsRotationSpeed;Clouds Rotation Speed;45;0;Create;True;0;0;0;False;0;False;0.1;-0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;228;-2827.519,5558.664;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;873;-531.3109,4996.896;Inherit;False;237;160;Comment;1;78;Add this to refraction;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;229;-2641.692,6139.368;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;992;-3172.032,3887.439;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;78;-485.137,5049.447;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;231;-2157.026,6123.119;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;230;-2157.843,5614.896;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;881;-3078.155,3229.269;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;682;-3156.586,1794.635;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;636;-3212.542,3036.497;Float;False;Property;_Eta;Eta;27;0;Create;True;0;0;0;False;0;False;-0.1;-0.1;-1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1027;-3366.408,2170.501;Inherit;False;Property;_RotationClouds;Rotation Clouds;33;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;638;-3284.745,646.787;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;648;-2800.675,524.4678;Float;False;Property;_RotationAxis;Rotation Axis;31;0;Create;True;0;0;0;False;0;False;0,1,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;1024;-2951.308,1797.801;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;643;-2887.724,3103.446;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;681;-3460.647,1942.114;Float;False;Property;_DarkCloudsRotationSpeed;Dark Clouds Rotation Speed;54;0;Create;True;0;0;0;False;0;False;0.1;-0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;990;-2991.216,3780.325;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;239;-1365.908,6123.498;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;639;-2754.798,701.553;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;233;-1338.3,5710.674;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;644;-2897.387,3028.102;Float;False;Constant;_Float26;Float 26;67;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;656;-3417.353,1771.343;Float;False;Property;_StarsRotationSpeed;Stars Rotation Speed;37;0;Create;True;0;0;0;False;0;False;0.1;-0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;655;-3156.621,1682.725;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;684;-2455.394,1052.8;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;645;-2721.083,3060.756;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;683;-3155.053,1908.05;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1028;-3398.408,2262.501;Inherit;False;Property;_RotationDarkClouds;Rotation Dark Clouds;34;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;685;-2454.642,1197.196;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;240;-1151.516,6131.879;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;848;-2873.067,2902.309;Float;False;Property;_EtaAAEdgesFix;Eta AA Edges Fix;30;0;Create;True;0;0;0;False;0;False;0;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;234;-1123.909,5719.054;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1026;-3354.408,2083.501;Inherit;False;Property;_RotationStars;Rotation Stars;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1023;-2950.109,1653.202;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;241;-982.0796,6132.682;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;235;-954.4726,5719.856;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1025;-2951.808,1933.001;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;795;-1828.616,923.3401;Float;False;//float d = clamp(dot(N, V) + In0, -1, 0)@$$float d = abs(dot(N, V) + In0) * -1@$$float k = 1.0 - Eta * Eta * (1.0 - d * d)@$$float3 R = Eta * V - (Eta * d + sqrt(k)) * N@$$return R@;3;Create;4;True;V;FLOAT3;0,0,0;In;;Float;False;True;N;FLOAT3;0,0,0;In;;Float;False;True;Eta;FLOAT;0;In;;Float;False;True;In0;FLOAT;0;In;;Float;False;RefractFixed;True;False;0;;False;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;652;-2466.727,835.2589;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;646;-2474.184,694.215;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;687;-2456.317,1530.771;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;242;-767.1501,6135.586;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;686;-2457.07,1391.404;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;674;-1518.508,1008.347;Inherit;True;Property;_CloudsTexture;Clouds Texture;41;0;Create;True;0;0;0;False;0;False;-1;None;58901cd10d76c174c89a5777624c6e6a;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1020;-1710.921,498.3676;Inherit;False;Property;_CloudsRampOffsetExp;Clouds Ramp Offset Exp;48;0;Create;True;0;0;0;False;0;False;1;2;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;236;-739.5433,5722.761;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1021;-1407.267,484.1797;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;243;-485.1071,6140.168;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;796;-1839.694,1720.417;Float;False;//float d = clamp(dot(N, V) + In0, -1, 0)@$$float d = abs(dot(N, V) + In0) * -1@$$float k = 1.0 - Eta * Eta * (1.0 - d * d)@$$float3 R = Eta * V - (Eta * d + sqrt(k)) * N@$$return R@;3;Create;4;True;V;FLOAT3;0,0,0;In;;Float;False;True;N;FLOAT3;0,0,0;In;;Float;False;True;Eta;FLOAT;0;In;;Float;False;True;In0;FLOAT;0;In;;Float;False;RefractFixed;True;False;1;-1;;False;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;797;-1831.613,611.5486;Float;False;//float d = clamp(dot(N, V) + In0, -1, 0)@$$float d = abs(dot(N, V) + In0) * -1@$$float k = 1.0 - Eta * Eta * (1.0 - d * d)@$$float3 R = Eta * V - (Eta * d + sqrt(k)) * N@$$return R@;3;Create;4;True;V;FLOAT3;0,0,0;In;;Float;False;True;N;FLOAT3;0,0,0;In;;Float;False;True;Eta;FLOAT;0;In;;Float;False;True;In0;FLOAT;0;In;;Float;False;RefractFixed;True;False;0;;False;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;237;-469.3369,5724.977;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;779;-1544.68,1807.274;Inherit;True;Property;_DarkCloudsTexture;Dark Clouds Texture;51;0;Create;True;0;0;0;False;0;False;-1;None;ffbea5a011efcb74ca83e46d218f6e11;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;744;-1251.821,478.69;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;245;-155.0458,5346.086;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;640;-1517.333,744.3656;Inherit;True;Property;_StarsTexture;Stars Texture;35;0;Create;True;0;0;0;False;0;False;-1;None;955c88d7e6663e349bd0dbbe199ed6ec;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;1037;-1742.307,-124.1655;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;83;-51.84834,5587.929;Float;False;Property;_RimColor;Rim Color;5;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1038;-1833.588,-26.36322;Inherit;False;Property;_StarsExp;Stars Exp;38;0;Create;True;0;0;0;False;0;False;1;2;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1019;-1259.54,654.5865;Inherit;False;Property;_CloudsRampOffsetExp2;Clouds Ramp Offset Exp 2;49;0;Create;True;0;0;0;False;0;False;1;1;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-68.75935,5499.254;Float;False;Property;_RimEmissionPower;Rim Emission Power;6;0;Create;True;0;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1013;40.41985,5194.965;Inherit;False;Property;_RimNoiseCAEnabled;Rim Noise CA Enabled;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1007;-1044.737,2062.663;Inherit;False;Property;_DarkCloudsEdgesGlowStyle;Dark Clouds Edges Glow Style;55;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1016;-1096.419,477.0397;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;789;-1029.79,2208.73;Float;False;Property;_DarkCloudsEdgesGlowExp;Dark Clouds Edges Glow Exp;57;0;Create;True;0;0;0;False;0;False;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;989;342.0074,3309.83;Inherit;False;1432.735;723.3853;;7;844;846;845;842;841;843;847;Rim Add Or Multiply;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1012;469.1115,5331.401;Inherit;False;559.2112;239.4468;;2;1010;1009;Switch;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;1039;-1564.087,-88.30531;Inherit;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1040;-1649.109,61.32269;Inherit;False;Property;_StarsExpNegate;Stars Exp Negate;39;0;Create;True;0;0;0;False;0;False;1;0.33;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;843;392.0073,3918.216;Float;False;Property;_RimAddOrMultiply;Rim Add Or Multiply;4;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;785;-858.3234,2294.856;Float;False;Property;_DarkCloudsEdgesGlowPower;Dark Clouds Edges Glow Power;56;0;Create;True;0;0;0;False;0;False;50;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;790;-722.7897,2131.223;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1017;-933.2974,477.0396;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1010;519.1115,5381.401;Inherit;False;Constant;_Float2;Float 2;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;282.5991,5464.671;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;841;716.814,3819.516;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1041;-1331.792,-35.39368;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;784;-548.8017,2239.594;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;804;-1503.173,1208.041;Float;False;Property;_CloudsOpacityExp;Clouds Opacity Exp;43;0;Create;True;0;0;0;False;0;False;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1009;763.3226,5432.848;Inherit;False;Property;_RimEnabled;Rim Enabled;3;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;786;-556.2809,2364.615;Float;False;Constant;_Float30;Float 30;85;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1018;-789.0407,481.4782;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;723;-1150.834,1304.644;Float;False;Property;_CloudsOpacityPower;Clouds Opacity Power;42;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;847;983.2371,3462.384;Float;False;Constant;_Float29;Float 29;91;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;720;-933.2144,967.456;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;844;986.9766,3359.83;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;803;-1179.173,1136.041;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;788;-597.8435,2477.823;Float;False;Property;_DarkCloudsEdgesGlowClamp;Dark Clouds Edges Glow Clamp;58;0;Create;True;0;0;0;False;0;False;2;4;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1043;-1301.002,-241.8665;Inherit;False;Property;_StarsColorTint;Stars Color Tint;40;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1042;-1185.086,-35.39282;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;777;-1003.08,1711.82;Float;False;Property;_DarkCloudsThicker;Dark Clouds Thicker;53;0;Create;True;0;0;0;False;0;False;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;783;-383.7878,2291.399;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1044;-994.9141,80.88341;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;787;-242.7002,2342.919;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;742;-604.294,440.3308;Float;False;Property;_StarsEmissionPower;Stars Emission Power;36;0;Create;True;0;0;0;False;0;False;4;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;776;-675.4274,1665.146;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;722;-792.6873,1234.019;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;735;-755.6593,728.4207;Float;False;Property;_CloudsRampColorTint;Clouds Ramp Color Tint;47;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;693;-786.6763,1795.079;Float;False;Property;_DarkCloudsLighten;Dark Clouds Lighten;52;0;Create;True;0;0;0;False;0;False;1;10;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;846;1177.126,3398.87;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;734;-759.2384,1144.644;Float;False;Property;_CloudsEmissionPower;Clouds Emission Power;44;0;Create;True;0;0;0;False;0;False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;719;-794.1144,929.7551;Inherit;True;Property;_CloudsRamp;Clouds Ramp;46;0;Create;True;0;0;0;False;0;False;-1;None;f6a2bbc30dc158c4abe2f66514b8d4cd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;733;-651.1667,1232.954;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;721;-318.9271,886.6669;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;741;-315.4207,740.2216;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;692;-488.2797,1724.31;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;869;-306.5292,436.7834;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;870;-306.3315,571.8486;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;772;-0.02860641,1012.773;Float;False;Constant;_Float28;Float 28;89;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;773;-338.8138,1724.398;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;740;-28.77713,772.1437;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;871;-57.90074,543.5685;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;745;219.9503,1012.369;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;77;1715.302,64.83354;Float;False;Property;_FinalPower;Final Power;0;0;Create;True;0;0;0;False;0;False;4;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;868;451.5213,742.9256;Float;False;Property;_DarkCloudsEnabled;Dark Clouds Enabled;50;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;842;1414.919,3783.874;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;845;1605.742,3753.578;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;1953.298,116.1366;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;637;-3269.239,1107.17;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;950;-5666.492,5694.995;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;949;-6412.601,5919.47;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;607;-9214.999,6026.693;Float;False;Constant;_Vector6;Vector 6;58;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;1036;2214.413,271.0514;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3445.168,-165.1498;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;SineVFX/GalaxyMaterials/GalaxyMaterial;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.Vector3Node;1045;-5400.325,405.2521;Inherit;False;Constant;_Vector0;Vector 0;59;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode;1047;-5217.316,408.7839;Inherit;False;View;World;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1048;-5149.316,560.784;Inherit;False;Property;_FOWFix;FOW Fix;59;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1049;-4938.316,478.7839;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1052;-5274.244,845.1905;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1054;-5080.378,768.481;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1055;-4933.931,765.6914;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;1053;-5337.064,697.384;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;1056;-4686.55,608.8688;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1059;-4538.206,616.9945;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
WireConnection;997;0;996;1
WireConnection;997;1;996;2
WireConnection;997;2;996;3
WireConnection;606;0;997;0
WireConnection;605;0;604;0
WireConnection;605;1;606;0
WireConnection;499;0;605;0
WireConnection;602;0;497;0
WireConnection;602;1;499;0
WireConnection;602;2;603;0
WireConnection;153;0;602;0
WireConnection;172;0;153;1
WireConnection;172;1;153;2
WireConnection;173;0;172;0
WireConnection;173;1;174;0
WireConnection;173;2;175;0
WireConnection;925;0;173;0
WireConnection;180;0;179;2
WireConnection;180;1;181;0
WireConnection;926;0;925;0
WireConnection;926;1;173;0
WireConnection;182;0;601;0
WireConnection;182;1;183;0
WireConnection;927;0;926;0
WireConnection;178;0;182;0
WireConnection;178;1;180;0
WireConnection;929;0;930;0
WireConnection;929;1;401;0
WireConnection;929;2;931;0
WireConnection;939;0;937;0
WireConnection;939;1;938;0
WireConnection;920;0;927;0
WireConnection;920;1;178;0
WireConnection;402;0;929;0
WireConnection;916;0;939;0
WireConnection;916;1;920;0
WireConnection;190;0;191;0
WireConnection;190;1;601;0
WireConnection;190;2;495;0
WireConnection;494;0;927;0
WireConnection;494;1;495;0
WireConnection;948;0;402;0
WireConnection;4;0;402;0
WireConnection;189;0;190;0
WireConnection;189;1;494;0
WireConnection;914;1;916;0
WireConnection;913;0;4;0
WireConnection;913;1;914;1
WireConnection;913;2;923;0
WireConnection;913;3;948;0
WireConnection;177;0;189;0
WireConnection;177;1;178;0
WireConnection;952;3;953;0
WireConnection;910;0;177;0
WireConnection;910;1;913;0
WireConnection;504;0;501;0
WireConnection;504;1;215;0
WireConnection;504;2;952;0
WireConnection;193;0;192;0
WireConnection;193;1;910;0
WireConnection;505;0;215;0
WireConnection;505;1;502;0
WireConnection;505;2;952;0
WireConnection;506;0;505;0
WireConnection;101;0;193;1
WireConnection;101;1;100;0
WireConnection;507;0;178;0
WireConnection;507;1;505;0
WireConnection;216;0;504;0
WireConnection;212;0;190;0
WireConnection;212;1;494;0
WireConnection;212;2;504;0
WireConnection;213;0;190;0
WireConnection;213;1;494;0
WireConnection;213;2;216;0
WireConnection;508;0;507;0
WireConnection;508;1;506;0
WireConnection;98;0;402;0
WireConnection;98;1;1059;0
WireConnection;98;2;101;0
WireConnection;210;0;212;0
WireConnection;210;1;507;0
WireConnection;211;0;213;0
WireConnection;211;1;508;0
WireConnection;102;0;98;0
WireConnection;911;0;210;0
WireConnection;911;1;913;0
WireConnection;17;0;102;0
WireConnection;642;3;664;0
WireConnection;912;0;211;0
WireConnection;912;1;913;0
WireConnection;217;0;192;0
WireConnection;217;1;911;0
WireConnection;218;0;192;0
WireConnection;218;1;912;0
WireConnection;132;0;17;0
WireConnection;132;1;19;0
WireConnection;799;0;642;0
WireConnection;220;0;217;1
WireConnection;220;1;100;0
WireConnection;879;0;799;0
WireConnection;221;0;218;1
WireConnection;221;1;100;0
WireConnection;119;0;132;0
WireConnection;227;0;402;0
WireConnection;227;1;1059;0
WireConnection;227;2;221;0
WireConnection;18;0;119;0
WireConnection;877;0;879;0
WireConnection;877;1;878;0
WireConnection;224;0;402;0
WireConnection;224;1;1059;0
WireConnection;224;2;220;0
WireConnection;20;0;18;0
WireConnection;20;1;21;0
WireConnection;880;0;877;0
WireConnection;228;0;224;0
WireConnection;229;0;227;0
WireConnection;992;0;991;0
WireConnection;78;0;20;0
WireConnection;231;0;229;0
WireConnection;230;0;228;0
WireConnection;881;0;880;0
WireConnection;682;0;654;2
WireConnection;682;1;680;0
WireConnection;1024;0;682;0
WireConnection;1024;1;1027;0
WireConnection;643;0;636;0
WireConnection;643;1;881;0
WireConnection;990;0;78;0
WireConnection;990;1;992;0
WireConnection;239;0;231;0
WireConnection;239;1;19;0
WireConnection;639;0;1059;0
WireConnection;233;0;230;0
WireConnection;233;1;19;0
WireConnection;655;0;654;2
WireConnection;655;1;656;0
WireConnection;684;0;648;0
WireConnection;684;1;1024;0
WireConnection;684;3;639;0
WireConnection;645;0;644;0
WireConnection;645;1;643;0
WireConnection;645;2;990;0
WireConnection;683;0;654;2
WireConnection;683;1;681;0
WireConnection;685;0;648;0
WireConnection;685;1;1024;0
WireConnection;685;3;402;0
WireConnection;240;0;239;0
WireConnection;234;0;233;0
WireConnection;1023;0;655;0
WireConnection;1023;1;1026;0
WireConnection;241;0;240;0
WireConnection;235;0;234;0
WireConnection;1025;0;683;0
WireConnection;1025;1;1028;0
WireConnection;795;0;684;0
WireConnection;795;1;685;0
WireConnection;795;2;645;0
WireConnection;795;3;848;0
WireConnection;652;0;648;0
WireConnection;652;1;1023;0
WireConnection;652;3;402;0
WireConnection;646;0;648;0
WireConnection;646;1;1023;0
WireConnection;646;3;639;0
WireConnection;687;0;648;0
WireConnection;687;1;1025;0
WireConnection;687;3;402;0
WireConnection;242;0;241;0
WireConnection;242;1;21;0
WireConnection;686;0;648;0
WireConnection;686;1;1025;0
WireConnection;686;3;639;0
WireConnection;674;1;795;0
WireConnection;236;0;235;0
WireConnection;236;1;21;0
WireConnection;1021;0;674;1
WireConnection;1021;1;1020;0
WireConnection;243;0;242;0
WireConnection;796;0;686;0
WireConnection;796;1;687;0
WireConnection;796;2;645;0
WireConnection;796;3;848;0
WireConnection;797;0;646;0
WireConnection;797;1;652;0
WireConnection;797;2;645;0
WireConnection;797;3;848;0
WireConnection;237;0;236;0
WireConnection;779;1;796;0
WireConnection;744;0;1021;0
WireConnection;245;0;78;0
WireConnection;245;1;237;0
WireConnection;245;2;243;0
WireConnection;640;1;797;0
WireConnection;1037;0;640;0
WireConnection;1013;1;78;0
WireConnection;1013;0;245;0
WireConnection;1007;0;779;2
WireConnection;1007;1;779;3
WireConnection;1016;0;744;0
WireConnection;1039;0;1037;0
WireConnection;1039;1;1038;0
WireConnection;790;0;1007;0
WireConnection;790;1;789;0
WireConnection;1017;0;1016;0
WireConnection;1017;1;1019;0
WireConnection;80;0;1013;0
WireConnection;80;1;82;0
WireConnection;80;2;83;0
WireConnection;841;2;843;0
WireConnection;1041;0;1039;0
WireConnection;1041;1;1040;0
WireConnection;784;0;790;0
WireConnection;784;1;785;0
WireConnection;1009;1;1010;0
WireConnection;1009;0;80;0
WireConnection;1018;0;1017;0
WireConnection;720;0;1018;0
WireConnection;844;0;1009;0
WireConnection;844;1;841;0
WireConnection;803;0;674;1
WireConnection;803;1;804;0
WireConnection;1042;0;1041;0
WireConnection;783;0;784;0
WireConnection;783;1;786;0
WireConnection;1044;0;1042;0
WireConnection;1044;1;640;0
WireConnection;1044;2;1043;0
WireConnection;787;0;783;0
WireConnection;787;2;788;0
WireConnection;776;0;779;1
WireConnection;776;1;777;0
WireConnection;722;0;803;0
WireConnection;722;1;723;0
WireConnection;846;0;844;0
WireConnection;846;1;847;0
WireConnection;719;1;720;0
WireConnection;733;0;722;0
WireConnection;721;0;719;0
WireConnection;721;1;734;0
WireConnection;721;2;735;0
WireConnection;721;3;787;0
WireConnection;721;4;846;0
WireConnection;741;0;1044;0
WireConnection;741;1;742;0
WireConnection;741;2;787;0
WireConnection;741;3;846;0
WireConnection;692;0;776;0
WireConnection;692;1;693;0
WireConnection;869;0;1044;0
WireConnection;869;1;742;0
WireConnection;869;2;846;0
WireConnection;870;0;719;0
WireConnection;870;1;734;0
WireConnection;870;2;735;0
WireConnection;870;3;846;0
WireConnection;773;0;692;0
WireConnection;740;0;741;0
WireConnection;740;1;721;0
WireConnection;740;2;733;0
WireConnection;871;0;869;0
WireConnection;871;1;870;0
WireConnection;871;2;733;0
WireConnection;745;0;772;0
WireConnection;745;1;740;0
WireConnection;745;2;773;0
WireConnection;868;1;871;0
WireConnection;868;0;745;0
WireConnection;842;0;841;0
WireConnection;845;0;1009;0
WireConnection;845;1;842;0
WireConnection;657;0;77;0
WireConnection;657;1;868;0
WireConnection;950;0;913;0
WireConnection;949;0;927;0
WireConnection;949;1;950;0
WireConnection;1036;0;657;0
WireConnection;1036;1;845;0
WireConnection;0;2;1036;0
WireConnection;1047;0;1045;0
WireConnection;1049;0;1047;0
WireConnection;1049;1;1048;0
WireConnection;1054;0;1053;0
WireConnection;1054;1;1052;0
WireConnection;1055;0;1054;0
WireConnection;1056;0;1049;0
WireConnection;1056;1;1055;0
WireConnection;1059;0;1056;0
ASEEND*/
//CHKSM=DFED6AA3585FF7F8952E5BC890AF117D90CD2617