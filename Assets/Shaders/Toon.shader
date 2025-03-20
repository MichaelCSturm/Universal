Shader "Roystan/Toon"
{
	Properties
	{
		_Color("Color", Color) = (0.5, 0.65, 1, 1)
		_MainTex("Main Texture", 2D) = "white" {}	
		_AmbientColor("Ambient Color", Color) = (0.4,0.4,0.4,1)
		[HDR]
		[NoScaleOffset] _HeightMap ("Height Map", 2D) = "gray" {}
		_SpecularColor("Spec color", Color) =(1,1,1,1)
		_Glossiness("Glossiness",Float)= 32
		_GradientCRamp1("CRamp right pos",Range (0, 1)) =1.0
		_GradientCRamp2("CRamp left pos",Range (0, 1)) =0.0
		_GradientCRampnum1("CRamp Clamp min",Range (0, 1)) =1.0
		_GradientCRampnum2("CRamp Clamp max",Range (0, 1)) =0.0
		_GradientColor1("ColorWhite", Color) = (0, 0, 0, 0)
		_GradientColor2("ColorDark", Color) = (1, 1, 1, 1)
		_numColors("Number of colors sampled from texture",Range(1,256))=16
		//_GradientLUT ("Gradient LUT", 2D) = "white" {}
		//_RotateGradient("GradientExtraRotate",Range (-360, 360)) =0.0
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_RimAmount("Rim Amount", Range(0, 1)) = 0.716
		_RimThreshold("Rim Threshold", Range(0, 1)) = 0.1
		

	}
	SubShader
	{
		Tags
		{
			"LightMode" = "ForwardBase"
			"PassFlags" = "OnlyDirectional"
		}
		Pass
		
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
			//float jo = 1.0;
			
			struct appdata
			{
				float4 vertex : POSITION;				
				float4 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				SHADOW_COORDS(2)
				float3 viewDir : TEXCOORD1;
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 worldNormal : NORMAL;
				//float4 vertex : 
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _HeightMap;
			// sampler2D _GradientLUT;
            // float4 _GradientLUT_ST;
			v2f vert (appdata v)
			{
				v2f o;
				
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//v2f oo;
				// o.pos = UnityObjectToClipPos(v.vertex);
				// o.uv.xy = TRANSFORM_TEX(v.uv.xy, _GradientLUT);
				// o.uv.xy = o.uv *2 -1;
				// float c = cos(180);
				// float s = sin(90);
				// float2x2 mat = float2x2(c,-s,
				// 						s,c);
				// o.uv.xy = mul(mat,o.uv.xy);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				o.viewDir = WorldSpaceViewDir(v.vertex);
				TRANSFER_SHADOW(o)
				return o;
			}
			
			float4 _Color;
			float4 _AmbientColor;
			float _Glossiness;
			float4 _SpecularColor;
			float _GradientCRamp1;
			float _GradientCRamp2;
			float _GradientCRampnum1;
			float _GradientCRampnum2;
			float4 _GradientColor1;
			float4 _GradientColor2;
			int _numColors;
			float _RotateGradient;
			float4 _RimColor;
			float _RimAmount;
			float _RimThreshold;
			
			float invLerp(float from, float to, float value){
				return (value - from) / (to - from);
			  }
			
			
			
			float4 textureColorMapping(float4 sample) : Color 
			{
				float4 output = floor(sample* (_numColors-1) + .5)/(_numColors-1);
				//float4 scolor =AdjustContrastCurve(sample,_Contrast);
				float4 hcolor = invLerp(_GradientCRampnum1,_GradientCRampnum2,output);
				
				// float4 rcolor = lerp(_GradientColor1,_GradientColor2,hcolor);

			// 	float _GradientCRamp1;
			// float _GradientCRamp2;
			// float _GradientCRampnum1;
			// float _GradientCRampnum2;
				// float4 firsthalf =  1/(_GradientCRamp1 - _GradientCRamp2);
				// float4 secondhalf = firsthalf * sample;
				// float4 thirdhalf = _GradientCRamp2/(_GradientCRamp2-_GradientCRamp1);
				// float4 fourthhalf = secondhalf + thirdhalf;
				// float4 fithhalf = invLerp(_GradientCRampnum1, _GradientCRampnum2,fourthhalf);
				// float4 sixhalf = lerp(_GradientColor1,_GradientColor2,fithhalf);
				float4 part1 = (1.0f / (_GradientCRamp1 - _GradientCRamp2)) * sample + (_GradientCRamp2 / (_GradientCRamp2 - _GradientCRamp1));
				float3 result = max(min(hcolor.rgb, 1), 0);
				float4 finalresult = lerp(_GradientColor1,_GradientColor2,float4(result,sample.a));

				return finalresult;
				//lerp(x, y, s)
				//
			}
			
			float4 frag (v2f i) : SV_Target
			{
				float3 normal = normalize(i.worldNormal);
				float NdotL = dot(_WorldSpaceLightPos0, normal);
				float shadow = SHADOW_ATTENUATION(i);

				float lightIntensity = smoothstep(0, 0.01, NdotL * shadow);
				//float lightIntensity = smoothstep(0, 0.01, NdotL);
				float3 viewDir = normalize(i.viewDir);

				//float3 halfVector = normalize(_WorldSpaceLightPos0 + viewDir);
				//float NdotH = dot(normal, halfVector);

			
				//float4 col = tex2D(_GradientLUT, cc);
				//float3 viewDir = normalize(i.viewDir);
				float4 sample = textureColorMapping(tex2D(_MainTex, i.uv));

				float4 light = lightIntensity * _LightColor0;
				float3 halfVector = normalize(_WorldSpaceLightPos0 + viewDir);
				float NdotH = dot(normal, halfVector);

				float specularIntensity = pow(NdotH * lightIntensity, _Glossiness * _Glossiness);
                float specularIntensitySmooth = smoothstep(0.005, 0.01, specularIntensity);
				float4 specular = specularIntensitySmooth * _SpecularColor;
				
				float4 rimDot = 1 - dot(viewDir, normal);
				float rimIntensity = rimDot * pow(NdotL, _RimThreshold);
				rimIntensity = smoothstep(_RimAmount - 0.01, _RimAmount + 0.01, rimIntensity);
				float4 rim = rimIntensity * _RimColor;

				return (_Color *  sample * (_AmbientColor+ light+ specular+ rim));
				//return sample;
			}
			ENDCG
		}
	}
}