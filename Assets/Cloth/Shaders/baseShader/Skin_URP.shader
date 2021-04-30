Shader "CustomURP/Skin_URP"
{
    Properties
    {
        _MainTexT ("Albedo", 2D) = "white" {}        
        _BaseColorT ("_BaseColorT",Color) = (1,1,1,1)   
        _ShadowColor ("ShadowColor",Color) = (0.47,0.31,0.40,1)
        _ShadeColor ("ShadeColor",Color) = (0.91,0.636,0.636,1)
        _SpecularColor ("高光颜色",Color) = (1,1,1,1)        
        _SpecularTex ("光滑度(R) 曲率(G) 附加阴影(B)", 2D) = "white" {} 
        _NormalMap ("Normal Map", 2D) = "bump" {}        
        _NormalMapScale("_NormalMapScale", Range(-2, 2)) = 1
        _LUTTex ("BRDF Lookup(RGB)", 2D) = "gray" {}
        _Fresnel ("菲涅尔",Range(0, 1)) = 0.124
        // _ShadowMaskSkin ("ShadowMaskSkin", 2D) = "white" {}
        _ShadowIntensity ("阴影浓度",Range(0, 3)) = 1.48
        _ExtraShadeRange ("附加阴影范围",Range(0, 3)) = 0.6

        // 外部传入
        _NN4AmbientTint ("NN4AmbientTint[环境光]",Color) = (1,1,1,1)
        _NN4Char_LightColor1 ("NN4Char_LightColor1",Color) = (0.31,0.31,0.31,1)
        [HDR]_NN4Char_LightColor2 ("NN4Char_LightColor2",Color) = (5.41,5.41,5.41,1)
        
        _NN4Char_LightDir1 ("NN4Char_LightDir1",Vector) = (-0.27,0.45,0.85,1)
        _NN4Char_LightDir2 ("NN4Char_LightDir2",Vector) = (0.72,0.369,-0.582,1)        
        
        
        _DeptheBias ("DeptheBias",float) = 1        
        _Smoothness ("粗糙度",Range(-1, 1)) = 0.124

        _Layer0Normal("Layer0Normal", 2D) = "bump"{}
		_Layer0NormalScale("Layer0NormalScale", float) = 1		
		[Enum(UV0,0, UV1,1, UV2,2, UV3, 3)] _Layer0UVSet("Layer0UVSet", float) = 0

		_Layer1Tex("Layer1Tex", 2D) = "black"{}
		_Layer1Mask("Layer1Mask", 2D) = "black"{}
		_Layer1Normal("Layer1Normal", 2D) = "bump"{}
		_Layer1NormalScale("Layer1NormalScale", float) = 1
		_Layer1Color("Layer1Color", Color) = (1,1,1,1)
		_Layer1Smoothness("Layer1Smoothness", Range(-1, 1)) = 0 
		_Layer1Metallic("Layer1Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer1UVSet("Layer1UVSet", float) = 0		


		_Layer2Tex("Layer2Tex", 2D) = "black"{}
		_Layer2Mask("Layer2Mask", 2D) = "black"{}
		_Layer2Normal("Layer2Normal", 2D) = "bump"{}
		_Layer2NormalScale("Layer2NormalScale", float) = 1
		_Layer2Color("Layer2Color", Color) = (1,1,1,1)
		_Layer2Smoothness("Layer2Smoothness", Range(-1, 1)) = 0 
		_Layer2Metallic("Layer2Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer2UVSet("Layer2UVSet", float) = 0
		

		_Layer3Tex("Layer3Tex", 2D) = "black"{}
        _Layer3Mask("Layer3Mask", 2D) = "black"{}
		_Layer3Normal("Layer3Normal", 2D) = "bump"{}
		_Layer3NormalScale("Layer3NormalScale", float) = 1
		_Layer3Color("Layer3Color", Color) = (1,1,1,1)
		_Layer3Smoothness("Layer3Smoothness", Range(-1, 1)) = 0 
		_Layer3Metallic("Layer3Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer3UVSet("Layer3UVSet", float) = 0		

		_Layer4Tex("Layer4Tex", 2D) = "black"{}
        _Layer4Mask("Layer4Mask", 2D) = "black"{}
		_Layer4Normal("Layer4Normal", 2D) = "bump"{}
		_Layer4NormalScale("Layer4NormalScale", float) = 1
		_Layer4Color("Layer4Color", Color) = (1,1,1,1)
		_Layer4Smoothness("Layer4Smoothness", Range(-1, 1)) = 0
		_Layer4Metallic("Layer4Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3, 3)] _Layer4UVSet("Layer4UVSet", float) = 0		

		_Layer5Tex("Layer5Tex", 2D) = "black"{}
        _Layer5Mask("Layer5Mask", 2D) = "black"{}
		_Layer5Normal("Layer5Normal", 2D) = "bump"{}
		_Layer5NormalScale("Layer5NormalScale", float) = 1
		_Layer5Color("Layer5Color", Color) = (1,1,1,1)
		_Layer5Smoothness("Layer5Smoothness", Range(-1, 1)) = 0
		_Layer5Metallic("Layer5Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3, 3)] _Layer5UVSet("Layer5UVSet", float) = 0		

		_Layer6Tex("Layer6Tex", 2D) = "black"{}
		_Layer6Mask("Layer6Mask", 2D) = "black"{}
		_Layer6Normal("Layer6Normal", 2D) = "bump"{}
		_Layer6NormalScale("Layer6NormalScale", float) = 1
		_Layer6Color("Layer6Color", Color) = (1,1,1,1)
		_Layer6Smoothness("Layer6Smoothness", Range(-1, 1)) = 0
		_Layer6Metallic("Layer6Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3, 3)] _Layer6UVSet("Layer6UVSet", float) = 0		
							
	    _Layer7Tex("Layer7Tex", 2D) = "black"{}
		_Layer7Mask("Layer7Mask", 2D) = "black"{}
		_Layer7Normal("Layer7Normal", 2D) = "bump"{}
		_Layer7NormalScale("Layer7NormalScale", float) = 1
		_Layer7Color("Layer7Color", Color) = (1,1,1,1)
		_Layer7Smoothness("Layer7Smoothness", Range(-1, 1)) = 0
		_Layer7Metallic("Layer7Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3, 3)] _Layer7UVSet("Layer7UVSet", float) = 0

        
    }
    SubShader
    {
        
        // Tags { "LightMode"="ForwardBase" "Classification" = "Skin"  "QUEUE" = "Geometry" "RenderType" = "NN4Skin" }          
        Tags { "LightMode"="ForwardBase" "RenderPipeline" ="UniversalPipeline"}      
        Pass
        {
            Tags { "LightMode"="UniversalForward" }                  
            HLSLPROGRAM
            
            #pragma target 3.0

            #pragma shader_feature_local _NORMALMAP
            
            #pragma shader_feature_local _LAYER_1_TEX
            #pragma shader_feature_local _LAYER_2_TEX
			#pragma shader_feature_local _LAYER_3_TEX
			#pragma shader_feature_local _LAYER_4_TEX
			#pragma shader_feature_local _LAYER_5_TEX
			#pragma shader_feature_local _LAYER_6_TEX
			#pragma shader_feature_local _LAYER_7_TEX
			

            #pragma shader_feature_local _LAYER_1_MASK
            #pragma shader_feature_local _LAYER_2_MASK
			#pragma shader_feature_local _LAYER_3_MASK
			#pragma shader_feature_local _LAYER_4_MASK
			#pragma shader_feature_local _LAYER_5_MASK
			#pragma shader_feature_local _LAYER_6_MASK
			#pragma shader_feature_local _LAYER_7_MASK

            #pragma shader_feature_local _LAYER_0_NORMAL
            #pragma shader_feature_local _LAYER_1_NORMAL
            #pragma shader_feature_local _LAYER_2_NORMAL
			#pragma shader_feature_local _LAYER_3_NORMAL
			#pragma shader_feature_local _LAYER_4_NORMAL
			#pragma shader_feature_local _LAYER_5_NORMAL
			#pragma shader_feature_local _LAYER_6_NORMAL			
			#pragma shader_feature_local _LAYER_7_NORMAL			

            #pragma shader_feature_local _Layer0UVSet_0 _Layer0UVSet_1 _Layer0UVSet_2 _Layer0UVSet_3
			#pragma shader_feature_local _Layer1UVSet_0 _Layer1UVSet_1 _Layer1UVSet_2 _Layer1UVSet_3
			#pragma shader_feature_local _Layer2UVSet_0 _Layer2UVSet_1 _Layer2UVSet_2 _Layer2UVSet_3
			#pragma shader_feature_local _Layer3UVSet_0 _Layer3UVSet_1 _Layer3UVSet_2 _Layer3UVSet_3
			#pragma shader_feature_local _Layer4UVSet_0 _Layer4UVSet_1 _Layer4UVSet_2 _Layer4UVSet_3
			#pragma shader_feature_local _Layer5UVSet_0 _Layer5UVSet_1 _Layer5UVSet_2 _Layer5UVSet_3
			#pragma shader_feature_local _Layer6UVSet_0 _Layer6UVSet_1 _Layer6UVSet_2 _Layer6UVSet_3
			#pragma shader_feature_local _Layer7UVSet_0 _Layer7UVSet_1 _Layer7UVSet_2 _Layer7UVSet_3
            
            #pragma vertex vert
            #pragma fragment frag                    
                        
            #define UNITY_INV_PI 1/PI
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"            
            
            struct appdata
            {
                float4 vertex  : POSITION;                
                float4 tangent : TANGENT;
                float3 normal  : NORMAL;
                float2 uv0      : TEXCOORD0;
                float2 uv1      : TEXCOORD1;
                float2 uv2      : TEXCOORD2;
                float2 uv3      : TEXCOORD3;

            };

            struct v2f
            {                
                float4 vertex : SV_POSITION;
                float4 uv     : TEXCOORD0;
		        float4 TtoW0  : TEXCOORD1;  
			    float4 TtoW1  : TEXCOORD2;  
			    float4 TtoW2  : TEXCOORD3;
			    float3 shlight: TEXCOORD4;
			    float4 detailUV: TEXCOORD5;
			    float4 tangentToWorldAndPackedData[3] : TEXCOORD6;			    
            };        
          
            float _NormalMapScale;
            float4 _BaseColorT;
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
            float _Smoothness;
            

 // --------------- Layer ----------                
                // layer transform and scale,use #if instead of #ifdef             
                // layer texture
                // TOD0: 优化公用采样器
                #if _LAYER_1_TEX 
                    TEXTURE2D(_Layer1Tex);    SAMPLER(sampler_Layer1Tex);                    
                    // sampler2D _Layer1Tex; 
                    half4 _Layer1Tex_ST;
                    real4 _Layer1Color;
                    half _Layer1Smoothness;
                    half _Layer1Metallic;
                #endif

                #if _LAYER_2_TEX                     
                    TEXTURE2D(_Layer2Tex);    SAMPLER(sampler_Layer2Tex);
                    half4 _Layer2Tex_ST;
                    real4 _Layer2Color;
                    half _Layer2Smoothness;
                    half _Layer2Metallic;
                #endif

                #if _LAYER_3_TEX                     
                    TEXTURE2D(_Layer3Tex);    SAMPLER(sampler_Layer3Tex);
                    half4 _Layer3Tex_ST;                  
                    real4 _Layer3Color;
                    half _Layer3Smoothness;
                    half _Layer3Metallic;
                #endif

                #if _LAYER_4_TEX 
                    TEXTURE2D(_Layer4Tex);    SAMPLER(sampler_Layer4Tex);
                    half4 _Layer4Tex_ST;                  
                    real4 _Layer4Color;
                    half _Layer4Smoothness;
                    half _Layer4Metallic;
                #endif

                #if _LAYER_5_TEX 
                    TEXTURE2D(_Layer5Tex);    SAMPLER(sampler_Layer5Tex);
                    half4 _Layer5Tex_ST;                  
                    real4 _Layer5Color;
                    half _Layer5Smoothness;
                    half _Layer5Metallic;
                #endif

                #if _LAYER_6_TEX 
                    TEXTURE2D(_Layer6Tex);    SAMPLER(sampler_Layer6Tex);
                    half4 _Layer6Tex_ST;
                    real4 _Layer6Color;
                    half _Layer6Smoothness;
                    half _Layer6Metallic;
                #endif

                #if _LAYER_7_TEX 
                    TEXTURE2D(_Layer7Tex);    SAMPLER(sampler_Layer7Tex);
                    half4 _Layer7Tex_ST;
                    real4 _Layer7Color;
                    half _Layer7Smoothness;
                    half _Layer7Metallic;
                #endif
                // layer mask 
                #if _LAYER_1_MASK
                    // sampler2D _Layer1Mask;
                    TEXTURE2D(_Layer1Mask);    SAMPLER(sampler_Layer1Mask);
                #endif
                #if _LAYER_2_MASK
                    TEXTURE2D(_Layer2Mask);    SAMPLER(sampler_Layer2Mask);
                #endif
                #if _LAYER_3_MASK
                    TEXTURE2D(_Layer3Mask);    SAMPLER(sampler_Layer3Mask);
                #endif
                #if _LAYER_4_MASK
                    TEXTURE2D(_Layer4Mask);    SAMPLER(sampler_Layer4Mask);
                #endif
                #if _LAYER_5_MASK
                    TEXTURE2D(_Layer5Mask);    SAMPLER(sampler_Layer5Mask);
                #endif
                #if _LAYER_6_MASK
                    TEXTURE2D(_Layer6Mask);    SAMPLER(sampler_Layer6Mask);
                #endif
                #if _LAYER_7_MASK
                    TEXTURE2D(_Layer7Mask);    SAMPLER(sampler_Layer7Mask);
                #endif

                // layer normal
                #if _LAYER_0_NORMAL // 第0层做平铺
                    // sampler2D _Layer0Normal;
                    TEXTURE2D(_Layer0Normal);    SAMPLER(sampler_Layer0Normal);
                    half4 _Layer0Normal_ST;
                    half _Layer0NormalScale;
                #endif

                #if _LAYER_1_NORMAL
                    TEXTURE2D(_Layer1Normal);    SAMPLER(sampler_Layer1Normal);
                    half4 _Layer1Normal_ST;
                    half _Layer1NormalScale;
                #endif

                #if _LAYER_2_NORMAL
                    TEXTURE2D(_Layer2Normal);    SAMPLER(sampler_Layer2Normal);                    
                    half _Layer2NormalScale;
                #endif

                #if _LAYER_3_NORMAL
                    TEXTURE2D(_Layer3Normal);    SAMPLER(sampler_Layer3Normal);
                    half _Layer3NormalScale;
                #endif

                #if _LAYER_4_NORMAL
                    TEXTURE2D(_Layer4Normal);    SAMPLER(sampler_Layer4Normal);
                    half _Layer4NormalScale;
                #endif

                #if _LAYER_5_NORMAL
                    TEXTURE2D(_Layer5Normal);    SAMPLER(sampler_Layer5Normal);
                    half _Layer5NormalScale;
                #endif

                #if _LAYER_6_NORMAL
                    TEXTURE2D(_Layer6Normal);    SAMPLER(sampler_Layer6Normal);
                    half _Layer6NormalScale;
                #endif

                #if _LAYER_7_NORMAL
                    TEXTURE2D(_Layer7Normal);    SAMPLER(sampler_Layer7Normal);
                    half _Layer7NormalScale;
                #endif
                
 // --------------- Layer ----------

            
            
            TEXTURE2D(_MainTexT);    SAMPLER(sampler_MainTexT);
            TEXTURE2D(_ShadowMaskSkin);    SAMPLER(sampler_ShadowMaskSkin);
            TEXTURE2D(_NormalMap);    SAMPLER(sampler_NormalMap);
            TEXTURE2D(_LUTTex);    SAMPLER(sampler_LUTTex);
            TEXTURE2D(_SpecularTex);    SAMPLER(sampler_SpecularTex);
            // TEXTURE2D_SAMPLER(_MainTexT);
            // // TEXTURE2D_SAMPLER(_ShadowMaskSkin);
            // TEXTURE2D_SAMPLER(_NormalMap);
            // TEXTURE2D_SAMPLER(_LUTTex);
            // TEXTURE2D_SAMPLER(_SpecularTex);
            #include "Tools_URP.cginc"

            half3 FresnelLerpNN (half3 F0, half cosA)
            {
                //  ndov^4 * __Fresnel + __Fresnel;  (2*__Fresnel < 1)
                half t = Pow4 (1 - cosA);
                return (1+t) * F0;                
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
                float4 clipPos = TransformObjectToHClip(v.vertex.xyz);                                
                // clipPos.z = -clipPos.z * _DeptheBias*0.1 + clipPos.z;                
                o.vertex = clipPos;
                o.uv.xy = v.uv0;                
                // 暂时换个位置
                // o.uv.zw = (o.vertex.xy / o.vertex.w)*0.5+0.5;
                // o.uv.zw = float2(o.uv.z,1 - o.uv.w);
                
                float3 worldNormal = TransformObjectToWorldNormal(v.normal);  
				float3 worldTangent = TransformObjectToWorldDir(v.tangent.xyz);                
				float3 worldBinormal = cross(worldNormal, worldTangent) * v.tangent.w; 
                float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;  
                o.TtoW0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);  
				o.TtoW1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);  
				o.TtoW2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);  

                o.tangentToWorldAndPackedData[0].xyz = worldTangent;
                o.tangentToWorldAndPackedData[1].xyz = worldBinormal;
                o.tangentToWorldAndPackedData[2].xyz = worldNormal;
                o.tangentToWorldAndPackedData[0].w = worldPos.x;
                o.tangentToWorldAndPackedData[1].w = worldPos.y;
                o.tangentToWorldAndPackedData[2].w = worldPos.z;

                float3 shlight = SampleSH(worldNormal);
                o.shlight = shlight;

                o.uv.zw = v.uv1;
                o.detailUV.xy = v.uv2;
                o.detailUV.zw = v.uv3;
                return o;
            }            
            float4 frag (v2f i) : SV_Target
            {        
                float3 baseColor = SAMPLE_TEXTURE2D(_MainTexT, sampler_MainTexT,i.uv).xyz;
                float3 albedoColor = baseColor*baseColor*_BaseColorT;
                real4 outColor = real4(albedoColor,1);
                float3 worldPos = float3(i.TtoW0.w, i.TtoW1.w, i.TtoW2.w);                				
                float3 worldViewDir = normalize(_WorldSpaceCameraPos.xyz - worldPos);
                float3 _normal_ = SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap,i.uv.xy);
                float _mask = _normal_.z;                                
				float3 worldNormal = UnpackNormal(SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, i.uv.xy)); // 非DXT5nm
				worldNormal = normalize(half3(dot(i.TtoW0.xyz, worldNormal), dot(i.TtoW1.xyz, worldNormal), dot(i.TtoW2.xyz, worldNormal)));
                // float3 t = ShadeSHPerPixel(worldNormal, float3(0.0, 0.0, 0.0), worldPos);                                 
             
                // R G B ,其中R通道是粗糙度 G 通道是厚度值 B AO图
                float4 funcTex = SAMPLE_TEXTURE2D(_SpecularTex,sampler_SpecularTex, i.uv.xy);
                // SmoothnessToRoughness的转换
                funcTex.z = 1 - funcTex.z;
                // float roughness = (1- funcTex.x)*(1-funcTex.x);
                // roughness = max(roughness,0.1);                                     
                
                FragmentCommonData s = MetallicSetup_FunDream(i.uv, i.detailUV, i.tangentToWorldAndPackedData,outColor);                
                float roughness = funcTex.x;
                roughness = roughness + s.smoothness; // 混合粗糙度
                float perceptualRoughness = 1 - roughness;
                roughness = max(perceptualRoughness*perceptualRoughness,0.1);                
                worldNormal = s.normalWorld; // 混合法线  
                float3 R = reflect(-worldViewDir, worldNormal); 
                float ndotv = max(dot(worldNormal,worldViewDir), 0);
                albedoColor = s.diffColor.xyz; // 混合diffuse                
                float3 IndirectSpecular = GlossyEnvironmentReflection(R, perceptualRoughness, 1)*_NN4AmbientTint;                
                float3 fresnel = FresnelLerpNN(_Fresnel,ndotv);
                IndirectSpecular = IndirectSpecular * fresnel * i.shlight;                
                // 取消G函数,减少脸部阴影计算
                float D = GGXTerm(ndotv,roughness);// 这里用nv代替nh 
                
                // float F = FresnelTerm(_Fresnel, ndotv);
                // float F = _Fresnel + (1-_Fresnel)*(1 - max(ndotv,0)) 
                float F = lerp(_Fresnel,1,1-max(ndotv,0));
                
                float3 SpecularColor = D*F*_NN4Char_LightColor1.xyz + IndirectSpecular;
                SpecularColor = SpecularColor *_SpecularColor;                
                // 阴影计算
                float ndotl_1 = dot(worldNormal,_NN4Char_LightDir1.xyz);
                float ndotl_2 = dot(worldNormal,_NN4Char_LightDir2.xyz);

                ndotl_2 = (ndotl_2+0.5)*0.66666669; // 范围控制在 [-1/3,1]，  lerp()
                ndotl_2 = max(ndotl_2,0); // 控制在 [0,1]
                ndotl_2 = pow(ndotl_2,4); // 4次计算，减少漫反射

                
                float3 _LightColor2 = ndotl_2 * _NN4Char_LightColor2 * albedoColor;
                _LightColor2 = _LightColor2 * albedoColor;                
                // _LightColor2 = _LightColor2*_mask;

                _LightColor2 = _LightColor2 / (_LightColor2+1); // 这里需要化简                            
                float depth = SAMPLE_TEXTURE2D(_ShadowMaskSkin,sampler_ShadowMaskSkin, i.uv.zw);
                                   
                depth = saturate(_ShadowIntensity*(depth - 1)+1);              
                ndotl_1 = (depth - 1)/4 + ndotl_1;
                ndotl_1 = ndotl_1 * 0.5 + 0.5; // float NdotL = dot(worldNormal, worldSpaceLightDir);
                float2 lutXY;
                lutXY.x = dot(worldNormal, _NN4Char_LightDir1);
                lutXY.x = lutXY.x - 0.25*_ShadowIntensity;//_Strength;
                lutXY.x = lutXY.x*0.5+0.5;
                ndotl_1 = lutXY.x;
                float3 _LUTColor = SAMPLE_TEXTURE2D(_LUTTex,sampler_LUTTex,float2(ndotl_1, funcTex.y));
                float3 _FinalShadowColor = _LUTColor * lerp(depth, 1, _ShadowColor.xyz);
                // _FinalShadowColor = _LUTColor;

                _FinalShadowColor = _FinalShadowColor * _NN4Char_LightColor1 + i.shlight;                
                _FinalShadowColor = albedoColor * _FinalShadowColor + _LightColor2;
            
                // 厚度图
                float ndotVRange =  min(ndotv / _ExtraShadeRange,1) - 1;
                ndotVRange = ndotVRange * funcTex.z + 1; 
                float3 _lerpShadeColor = lerp(_ShadeColor,1,ndotVRange);
                // diffuse + specular
                // SpecularColor = 0;
                float3 finalColor = _FinalShadowColor * _lerpShadeColor + SpecularColor;
                
                return float4(finalColor, 1);

            }           
            ENDHLSL            
        }        
    }
    CustomEditor "SkinShaderGUI_Layer"
}
