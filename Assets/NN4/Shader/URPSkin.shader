// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "NN/URP_Skin"
{
    Properties
    {
        _MainTexBase ("Albedo", 2D) = "white" {}        
        _ShadowColor ("ShadowColor",Color) = (0.47,0.31,0.40,1)
        _ShadeColor ("ShadeColor",Color) = (0.91,0.636,0.636,1)
        _SpecularColor ("高光颜色",Color) = (1,1,1,1)        
        _SpecularTex ("光滑�?(R) 曲率(G) 附加阴影(B)", 2D) = "white" {}  // R G B ,其中R通道是粗糙度 G 通道是厚度�? B AO�?
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _LUTTex ("BRDF Lookup(RGB)", 2D) = "gray" {}
        _Fresnel ("菲涅�?",Range(0, 1)) = 0.124        
        _ShadowIntensity ("阴影浓度",Range(0, 3)) = 1.48
        _ExtraShadeRange ("附加阴影范围",Range(0, 1)) = 1.0

        
        _NN4AmbientTint ("NN4AmbientTint[环境光]",Color) = (1,1,1,1)
        _NN4Char_LightColor1 ("NN4Char_LightColor1",Color) = (0.31,0.31,0.31,1)
        [HDR]_NN4Char_LightColor2 ("NN4Char_LightColor2",Color) = (5.419,5.419,5.419,1)
        
        _NN4Char_LightDir1 ("NN4Char_LightDir1",Vector) = (-0.27025,0.4524,0.84986,1)
        _NN4Char_LightDir2 ("NN4Char_LightDir2",Vector) = (0.724,0.369,-0.595,1)        
        
        
        _DeptheBias ("DeptheBias",float) = 0
        _DepthStrength ("DepthStrength",float) = 1

        // unity_SpecularCube0_HDR = (2,1,0,0)
        
    }
    SubShader
    {
        Tags { "LightMode"="ForwardBase" "RenderType" = "Opaque" "QUEUE" = "Geometry"}
        // Tags { "LightMode"="ForwardBase" "Classification" = "Skin"  "QUEUE" = "Geometry" "RenderType" = "NN4Skin" }  
        // WorldSpaceCameraPos = (0,1.28272,4.40)
        // CameraFov = 24
        // Angle = (6.3,180,0)
        Pass
        {
			Tags { "LightMode"="UniversalForward" }
			HLSLPROGRAM
             #pragma target 3.0
          
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_INV_PI 1/3.14            
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"            
            struct appdata
            {
                float4 vertex  : POSITION;
                float2 uv      : TEXCOORD0;
                float4 tangent : TANGENT;
                float3 normal  : NORMAL;
            };

            struct v2f
            {                
                float4 vertex : SV_POSITION;
                float4 uv     : TEXCOORD0;            
		        float4 TtoW0  : TEXCOORD1;  
			    float4 TtoW1  : TEXCOORD2;  
			    float4 TtoW2  : TEXCOORD3;
			    float3 shlight: TEXCOORD4;
			    // float4 Test: TEXCOORD5;
			    
            };
            
            TEXTURE2D(_MainTexBase);    SAMPLER(sampler_MainTexBase);
            TEXTURE2D(posm_ShadowMaskSkin);    SAMPLER(sampler_posm_ShadowMaskSkin);
            TEXTURE2D(_NormalMap);    SAMPLER(sampler_NormalMap);
            TEXTURE2D(_LUTTex);    SAMPLER(sampler_LUTTex);
            TEXTURE2D(_SpecularTex);    SAMPLER(sampler_SpecularTex);

            float4 _ShadowColor;
            float4 _ShadeColor;
            float4 _NN4AmbientTint;
            float4 _NN4Char_LightColor1;
            float4 _NN4Char_LightColor2;
            float4 _NN4Char_LightDir1;
            float4 _NN4Char_LightDir2;
            float4 _SpecularColor;
            
            
            float _Fresnel;
            float _ShadowIntensity;
            float _ExtraShadeRange;
            float _DeptheBias;
            float _DepthStrength;
            
            half3 FresnelLerpNN (half3 F0, half cosA)
            {
                //  ndov^4 * __Fresnel + __Fresnel;  (2*__Fresnel < 1)
                half t = Pow4 (1 - cosA);
                return (1+t) * F0;                
            }
            half3 FresnelLerpNN2 (half _Fresnel, half ndotv)
            {
                half fresnel = min(_Fresnel*2,1.0) - _Fresnel;
                ndotv = 1- ndotv;
                fresnel = pow(ndotv,4)*fresnel + _Fresnel;
                return half3(fresnel,fresnel,fresnel);
            }
            float GGXTerm(float NdotH, float roughness)
            {
                float a2 = roughness * roughness;
                float d = (NdotH * a2 - NdotH) * NdotH + 1.0f; // 2 mad
                return UNITY_INV_PI * a2 / (d * d + 1e-7f); // This function is not intended to be running on Mobile,
                                                        // therefore epsilon is smaller than what can be represented by half
            }
            v2f vert (appdata v)
            {
                v2f o;                                                                                                               
                float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                // float4 clipPos = mul(UNITY_MATRIX_VP, worldPos);
                float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
                clipPos.z = -clipPos.z * _DeptheBias*0.1 + clipPos.z;                
                o.vertex = clipPos;
                o.uv.xy = v.uv;                
                o.uv.zw = (o.vertex.xy / o.vertex.w)*0.5+0.5;

                float3 worldNormal = TransformObjectToWorldNormal(v.normal);  
				float3 worldTangent = TransformObjectToWorldDir(v.tangent.xyz);                
				float3 worldBinormal = cross(worldNormal, worldTangent) * v.tangent.w; 				                            
                worldBinormal = normalize(worldBinormal);

                o.TtoW0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);  
				o.TtoW1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);  
				o.TtoW2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);  
               
                // float3 shlight = ShadeSH9 (float4(worldNormal, 1.0));
                float3 shlight = SampleSHVertex(worldNormal);
                o.shlight = shlight;
                //o.Test.xyz = v.tangent.xyz;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {			                
            #if !defined(UNITY_NO_LINEAR_COLORSPACE)
                _NN4Char_LightColor1 = pow(_NN4Char_LightColor1,0.45);
                i.shlight = pow(i.shlight,0.45);                  
            #endif                
                return float4(i.shlight,1);
                float3 baseColor = SAMPLE_TEXTURE2D(_MainTexBase, sampler_MainTexBase,i.uv).xyz;
                
                float3 _BaseColor = baseColor*baseColor;
                float3 worldPos = float3(i.TtoW0.w, i.TtoW1.w, i.TtoW2.w);
                float3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - worldPos);
                
                float3 worldNormal = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap,i.uv.xy);
                worldNormal.xy = worldNormal.xy*2 -1;
                float _mask = worldNormal.z;
                worldNormal.z = sqrt(1 - saturate(dot(worldNormal.xy, worldNormal.xy)));                
				worldNormal = normalize(float3(dot(i.TtoW0.xyz, worldNormal), dot(i.TtoW1.xyz, worldNormal), dot(i.TtoW2.xyz, worldNormal)));
                // float3 t = ShadeSHPerPixel(worldNormal, float3(0.0, 0.0, 0.0), worldPos);                                 
                float3 R = reflect(-worldViewDir, worldNormal); 
                float ndotv = max(dot(worldNormal,worldViewDir), 0);                
                
                float4 funcTex = SAMPLE_TEXTURE2D(_SpecularTex,sampler_SpecularTex, i.uv.xy);
                
                funcTex.z = 1 - funcTex.z;
                
                float roughness = (1- funcTex.x)*(1-funcTex.x);
                roughness = max(roughness,0.1);
                half perceptualRoughness = roughness;
                                              
                float3 IndirectSpecular = GlossyEnvironmentReflection(R,perceptualRoughness,1);                
                IndirectSpecular = IndirectSpecular * _NN4AmbientTint;
				
                float3 fresnel = FresnelLerpNN2(_Fresnel,ndotv);
                IndirectSpecular = IndirectSpecular * fresnel* i.shlight;      				
                
                float D = GGXTerm(ndotv,roughness);// nv instead nh.                                
                // float F = _Fresnel + (1-_Fresnel)*(1 - max(ndotv,0)) 
                float F = lerp(_Fresnel,1,1-max(ndotv,0));                
                float3 SpecularColor = D*F*_NN4Char_LightColor1.xyz + IndirectSpecular;
                SpecularColor = SpecularColor *_SpecularColor;
				
                float ndotl_1 = dot(worldNormal,_NN4Char_LightDir1);
                float ndotl_2 = dot(worldNormal,_NN4Char_LightDir2);

                ndotl_2 = (ndotl_2+0.5)*0.66666669; 
                ndotl_2 = max(ndotl_2,0);
                ndotl_2 = pow(ndotl_2,4); 
                
                float3 _LightColor2 = ndotl_2 * _NN4Char_LightColor2 * _BaseColor;                
                _LightColor2 = _LightColor2*_mask;
                _LightColor2 = _LightColor2 / (_LightColor2+1);
                          
                float depth = SAMPLE_TEXTURE2D(posm_ShadowMaskSkin,sampler_posm_ShadowMaskSkin, i.uv.zw);
                float depthTemp = saturate(_ShadowIntensity*(depth - 1) + 1);
				depth = depthTemp - 1;				
                ndotl_1 = depth/4 + ndotl_1;
                ndotl_1 = ndotl_1 * 0.5 + 0.5;                                 
				float3 _LUTColor = SAMPLE_TEXTURE2D(_LUTTex,sampler_LUTTex,float2(ndotl_1, funcTex.y));
                
                float3 _FinalShadowColor = _LUTColor * lerp(_ShadowColor.xyz, half3(1,1,1), depthTemp);                

                _FinalShadowColor = _FinalShadowColor * _NN4Char_LightColor1 + i.shlight;                
                _FinalShadowColor = _BaseColor * _FinalShadowColor + _LightColor2;                                            
                float ndotVRange =  min(ndotv / _ExtraShadeRange,1) - 1;
                ndotVRange = ndotVRange * funcTex.z + 1;
                float3 _lerpShadeColor = lerp(_ShadeColor,1,ndotVRange);
                float3 finalColor = _FinalShadowColor * _lerpShadeColor + SpecularColor;	
                // return float4(i.shlight*6, 1);
                return float4(finalColor, 1);
            }
            ENDHLSL
        }
    }
}
