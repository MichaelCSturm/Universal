// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SineVFX/GalaxyMaterials/GalaxyMaterialSkybox"
{
	Properties
	{
		_FinalPower("Final Power", Float) = 4
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
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _DARKCLOUDSENABLED_ON
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _FinalPower;
		uniform samplerCUBE _StarsTexture;
		uniform float3 _RotationAxis;
		uniform float _StarsRotationSpeed;
		uniform float _RotationStars;
		uniform float _FOWFix;
		uniform float _StarsExp;
		uniform float _StarsExpNegate;
		uniform float4 _StarsColorTint;
		uniform float _StarsEmissionPower;
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


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 viewToWorldDir1038 = mul( UNITY_MATRIX_I_V, float4( float3(0,0,1), 0 ) ).xyz;
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult1043 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			float3 normalizeResult1046 = normalize( ( ( viewToWorldDir1038 * _FOWFix ) + normalizeResult1043 ) );
			float3 rotatedValue646 = RotateAroundAxis( float3( 0,0,0 ), -normalizeResult1046, normalize( _RotationAxis ), ( ( _Time.y * _StarsRotationSpeed ) + _RotationStars ) );
			float4 texCUBENode640 = texCUBE( _StarsTexture, rotatedValue646 );
			float3 desaturateInitialColor1031 = texCUBENode640.rgb;
			float desaturateDot1031 = dot( desaturateInitialColor1031, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar1031 = lerp( desaturateInitialColor1031, desaturateDot1031.xxx, 1.0 );
			float3 temp_cast_1 = (_StarsExp).xxx;
			float3 clampResult1035 = clamp( ( pow( desaturateVar1031 , temp_cast_1 ) + _StarsExpNegate ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float4 temp_output_1032_0 = ( float4( clampResult1035 , 0.0 ) * texCUBENode640 * _StarsColorTint );
			float3 rotatedValue684 = RotateAroundAxis( float3( 0,0,0 ), -normalizeResult1046, normalize( _RotationAxis ), ( ( _Time.y * _CloudsRotationSpeed ) + _RotationClouds ) );
			float4 texCUBENode674 = texCUBE( _CloudsTexture, rotatedValue684 );
			float clampResult744 = clamp( pow( texCUBENode674.r , _CloudsRampOffsetExp ) , 0.0 , 1.0 );
			float2 appendResult720 = (float2(( 1.0 - pow( ( 1.0 - clampResult744 ) , _CloudsRampOffsetExp2 ) ) , 0.0));
			float4 tex2DNode719 = tex2D( _CloudsRamp, appendResult720 );
			float clampResult733 = clamp( ( pow( texCUBENode674.r , _CloudsOpacityExp ) * _CloudsOpacityPower ) , 0.0 , 1.0 );
			float4 lerpResult871 = lerp( ( temp_output_1032_0 * _StarsEmissionPower ) , ( tex2DNode719 * _CloudsEmissionPower * _CloudsRampColorTint ) , clampResult733);
			float4 temp_cast_3 = (0.0).xxxx;
			float3 rotatedValue686 = RotateAroundAxis( float3( 0,0,0 ), -normalizeResult1046, normalize( _RotationAxis ), ( ( _Time.y * _DarkCloudsRotationSpeed ) + _RotationDarkClouds ) );
			float4 texCUBENode779 = texCUBE( _DarkCloudsTexture, rotatedValue686 );
			float clampResult787 = clamp( ( ( pow( (( _DarkCloudsEdgesGlowStyle )?( texCUBENode779.b ):( texCUBENode779.g )) , _DarkCloudsEdgesGlowExp ) * _DarkCloudsEdgesGlowPower ) + 1.0 ) , 0.0 , _DarkCloudsEdgesGlowClamp );
			float4 lerpResult740 = lerp( ( temp_output_1032_0 * _StarsEmissionPower * clampResult787 ) , ( tex2DNode719 * _CloudsEmissionPower * _CloudsRampColorTint * clampResult787 ) , clampResult733);
			float clampResult773 = clamp( ( pow( texCUBENode779.r , _DarkCloudsThicker ) * _DarkCloudsLighten ) , 0.0 , 1.0 );
			float4 lerpResult745 = lerp( temp_cast_3 , lerpResult740 , clampResult773);
			#ifdef _DARKCLOUDSENABLED_ON
				float4 staticSwitch868 = lerpResult745;
			#else
				float4 staticSwitch868 = lerpResult871;
			#endif
			o.Emission = ( _FinalPower * staticSwitch868 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.CommentaryNode;1015;-2926.268,-252.2967;Inherit;False;4285.613;2206.039;;62;868;804;674;744;720;742;734;640;722;735;719;741;733;721;870;740;869;871;803;723;745;772;681;638;654;680;683;682;648;639;686;684;656;655;646;779;777;693;776;692;773;789;1007;785;790;786;784;783;787;788;1016;1017;1018;1019;1020;1021;1023;1025;1024;1026;1027;1028;Main Background;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;680;-2727.903,771.9938;Float;False;Property;_CloudsRotationSpeed;Clouds Rotation Speed;15;0;Create;True;0;0;0;False;0;False;0.1;-0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;654;-2681.085,543.2276;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;682;-2456.5,715.1676;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1027;-2666.323,1091.034;Inherit;False;Property;_RotationClouds;Rotation Clouds;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;638;-2577.608,41.40551;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;656;-2717.268,691.8756;Float;False;Property;_StarsRotationSpeed;Stars Rotation Speed;7;0;Create;True;0;0;0;False;0;False;0.1;-0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;639;-2168.975,62.47277;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;648;-2214.852,-114.6125;Float;False;Property;_RotationAxis;Rotation Axis;1;0;Create;True;0;0;0;False;0;False;0,1,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;1024;-2251.223,718.3336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;681;-2760.562,862.6467;Float;False;Property;_DarkCloudsRotationSpeed;Dark Clouds Rotation Speed;24;0;Create;True;0;0;0;False;0;False;0.1;-0.04;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1028;-2698.323,1183.034;Inherit;False;Property;_RotationDarkClouds;Rotation Dark Clouds;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;684;-1869.57,413.7197;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;683;-2454.968,828.5826;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1026;-2654.323,1004.034;Inherit;False;Property;_RotationStars;Rotation Stars;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;655;-2456.536,603.2578;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1023;-2250.023,573.7347;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;674;-932.6844,369.2668;Inherit;True;Property;_CloudsTexture;Clouds Texture;11;0;Create;True;0;0;0;False;0;False;-1;None;399d11aecb04914488a63bbf3cc1223b;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1025;-2251.723,853.5336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1020;-1125.097,-140.7126;Inherit;False;Property;_CloudsRampOffsetExp;Clouds Ramp Offset Exp;18;0;Create;True;0;0;0;False;0;False;1;2;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;686;-1871.246,752.3236;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;1021;-821.4434,-154.9005;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;646;-1888.36,55.13482;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;640;-931.5094,105.2854;Inherit;True;Property;_StarsTexture;Stars Texture;5;0;Create;True;0;0;0;False;0;False;-1;None;0ade5b5c267f61441a1c0caee8524b42;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;744;-665.9974,-160.3902;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;779;-928.3567,827.61;Inherit;True;Property;_DarkCloudsTexture;Dark Clouds Texture;21;0;Create;True;0;0;0;False;0;False;-1;None;f805b72387a8dd44fb6c702092f96667;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1030;-892.0582,-660.9426;Inherit;False;Property;_StarsExp;Stars Exp;8;0;Create;True;0;0;0;False;0;False;1;2;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1007;-458.9135,1423.583;Inherit;False;Property;_DarkCloudsEdgesGlowStyle;Dark Clouds Edges Glow Style;25;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;789;-443.9665,1569.65;Float;False;Property;_DarkCloudsEdgesGlowExp;Dark Clouds Edges Glow Exp;27;0;Create;True;0;0;0;False;0;False;1;1;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1016;-510.5954,-162.0405;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1019;-673.7164,15.50629;Inherit;False;Property;_CloudsRampOffsetExp2;Clouds Ramp Offset Exp 2;19;0;Create;True;0;0;0;False;0;False;1;1;0.2;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;1031;-800.7776,-758.7449;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;785;-272.4999,1655.776;Float;False;Property;_DarkCloudsEdgesGlowPower;Dark Clouds Edges Glow Power;26;0;Create;True;0;0;0;False;0;False;50;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1017;-347.4739,-162.0406;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;790;-136.9661,1492.143;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1033;-707.5798,-573.2567;Inherit;False;Property;_StarsExpNegate;Stars Exp Negate;9;0;Create;True;0;0;0;False;0;False;1;0.33;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1029;-622.5571,-722.8847;Inherit;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1034;-390.2622,-669.9731;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;804;-917.3494,568.9606;Float;False;Property;_CloudsOpacityExp;Clouds Opacity Exp;13;0;Create;True;0;0;0;False;0;False;1;2;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;786;29.54266,1725.535;Float;False;Constant;_Float30;Float 30;85;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1018;-203.2172,-157.602;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;784;37.02185,1600.514;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;723;-565.0104,665.5636;Float;False;Property;_CloudsOpacityPower;Clouds Opacity Power;12;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;803;-593.3494,496.9608;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;783;202.0357,1652.319;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;720;-347.3909,328.3758;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;1035;-243.5567,-669.9722;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1036;-359.472,-876.4459;Inherit;False;Property;_StarsColorTint;Stars Color Tint;10;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;788;-12.01994,1838.743;Float;False;Property;_DarkCloudsEdgesGlowClamp;Dark Clouds Edges Glow Clamp;28;0;Create;True;0;0;0;False;0;False;2;4;1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;777;-417.2564,1072.74;Float;False;Property;_DarkCloudsThicker;Dark Clouds Thicker;23;0;Create;True;0;0;0;False;0;False;1;0.75;0.2;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1032;-53.38476,-553.696;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;734;-173.4148,505.5638;Float;False;Property;_CloudsEmissionPower;Clouds Emission Power;14;0;Create;True;0;0;0;False;0;False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;787;343.1234,1703.839;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;719;-208.2909,290.6748;Inherit;True;Property;_CloudsRamp;Clouds Ramp;16;0;Create;True;0;0;0;False;0;False;-1;None;6f30dac5ca0eb004cada97d25c2cedf0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;742;-18.47044,-198.7494;Float;False;Property;_StarsEmissionPower;Stars Emission Power;6;0;Create;True;0;0;0;False;0;False;4;6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;693;-200.8528,1155.999;Float;False;Property;_DarkCloudsLighten;Dark Clouds Lighten;22;0;Create;True;0;0;0;False;0;False;1;1.25;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;735;-169.8358,89.34053;Float;False;Property;_CloudsRampColorTint;Clouds Ramp Color Tint;17;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,0.3382278,0.3382278,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;722;-206.8638,594.9387;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;776;-89.60388,1026.066;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;721;266.8965,247.5865;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;692;97.5438,1085.23;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;741;270.4029,101.1414;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;733;-65.34312,593.8737;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;740;557.0465,133.0634;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;870;279.492,-67.23166;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;773;247.0097,1085.318;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;772;585.7949,373.6928;Float;False;Constant;_Float28;Float 28;89;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;869;279.2943,-202.2968;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;745;805.7739,373.2887;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;871;527.9228,-95.51175;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;868;1037.345,103.8454;Float;False;Property;_DarkCloudsEnabled;Dark Clouds Enabled;20;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;77;1552.302,-27.16646;Float;False;Property;_FinalPower;Final Power;0;0;Create;True;0;0;0;False;0;False;4;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;1837.298,90.1366;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3445.168,-165.1498;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;SineVFX/GalaxyMaterials/GalaxyMaterialSkybox;False;False;False;False;True;True;True;True;True;False;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.Vector3Node;1037;-4321.717,-379.5763;Inherit;False;Constant;_Vector0;Vector 0;59;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode;1038;-4138.708,-376.0445;Inherit;False;View;World;False;Fast;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1040;-3859.708,-306.0445;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1041;-4195.636,60.36212;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1042;-4001.77,-16.34735;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1043;-3855.323,-19.13696;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;1044;-4258.456,-87.4444;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;1045;-3607.941,-175.9596;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1046;-3459.598,-167.8339;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1039;-4070.708,-225.0444;Inherit;False;Property;_FOWFix;FOW Fix;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
WireConnection;682;0;654;2
WireConnection;682;1;680;0
WireConnection;639;0;1046;0
WireConnection;1024;0;682;0
WireConnection;1024;1;1027;0
WireConnection;684;0;648;0
WireConnection;684;1;1024;0
WireConnection;684;3;639;0
WireConnection;683;0;654;2
WireConnection;683;1;681;0
WireConnection;655;0;654;2
WireConnection;655;1;656;0
WireConnection;1023;0;655;0
WireConnection;1023;1;1026;0
WireConnection;674;1;684;0
WireConnection;1025;0;683;0
WireConnection;1025;1;1028;0
WireConnection;686;0;648;0
WireConnection;686;1;1025;0
WireConnection;686;3;639;0
WireConnection;1021;0;674;1
WireConnection;1021;1;1020;0
WireConnection;646;0;648;0
WireConnection;646;1;1023;0
WireConnection;646;3;639;0
WireConnection;640;1;646;0
WireConnection;744;0;1021;0
WireConnection;779;1;686;0
WireConnection;1007;0;779;2
WireConnection;1007;1;779;3
WireConnection;1016;0;744;0
WireConnection;1031;0;640;0
WireConnection;1017;0;1016;0
WireConnection;1017;1;1019;0
WireConnection;790;0;1007;0
WireConnection;790;1;789;0
WireConnection;1029;0;1031;0
WireConnection;1029;1;1030;0
WireConnection;1034;0;1029;0
WireConnection;1034;1;1033;0
WireConnection;1018;0;1017;0
WireConnection;784;0;790;0
WireConnection;784;1;785;0
WireConnection;803;0;674;1
WireConnection;803;1;804;0
WireConnection;783;0;784;0
WireConnection;783;1;786;0
WireConnection;720;0;1018;0
WireConnection;1035;0;1034;0
WireConnection;1032;0;1035;0
WireConnection;1032;1;640;0
WireConnection;1032;2;1036;0
WireConnection;787;0;783;0
WireConnection;787;2;788;0
WireConnection;719;1;720;0
WireConnection;722;0;803;0
WireConnection;722;1;723;0
WireConnection;776;0;779;1
WireConnection;776;1;777;0
WireConnection;721;0;719;0
WireConnection;721;1;734;0
WireConnection;721;2;735;0
WireConnection;721;3;787;0
WireConnection;692;0;776;0
WireConnection;692;1;693;0
WireConnection;741;0;1032;0
WireConnection;741;1;742;0
WireConnection;741;2;787;0
WireConnection;733;0;722;0
WireConnection;740;0;741;0
WireConnection;740;1;721;0
WireConnection;740;2;733;0
WireConnection;870;0;719;0
WireConnection;870;1;734;0
WireConnection;870;2;735;0
WireConnection;773;0;692;0
WireConnection;869;0;1032;0
WireConnection;869;1;742;0
WireConnection;745;0;772;0
WireConnection;745;1;740;0
WireConnection;745;2;773;0
WireConnection;871;0;869;0
WireConnection;871;1;870;0
WireConnection;871;2;733;0
WireConnection;868;1;871;0
WireConnection;868;0;745;0
WireConnection;657;0;77;0
WireConnection;657;1;868;0
WireConnection;0;2;657;0
WireConnection;1038;0;1037;0
WireConnection;1040;0;1038;0
WireConnection;1040;1;1039;0
WireConnection;1042;0;1044;0
WireConnection;1042;1;1041;0
WireConnection;1043;0;1042;0
WireConnection;1045;0;1040;0
WireConnection;1045;1;1043;0
WireConnection;1046;0;1045;0
ASEEND*/
//CHKSM=D99CFD596617A1FDCF7BC00BEC22AF3709BC3C48