Shader "Custom/URP_SkinShadowmask"
{
    Properties
    {
         _DepthBias ("_DepthBias", float) = 0.0
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipelinpute"="UniversalRenderPipelinpute"}

        Pass
        {
            Tags { "LightMode"="UniversalForward" }
			Cull back

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag			
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			// use SAMPLE_TEXTURE2D_LOD instead.
            // #define UNITY_SAMPLE_SHADOW_NN(tex,coord) (coord.z >= tex2Dlod(tex,float4(coord.xy,0,0)) ? 1.0 : 0.0)
            #define UNITY_SAMPLE_SHADOW_NN(textureName,uv) ( uv.z >= textureName.SampleLevel(sampler##textureName, uv.xy, 0) ? 1.0 : 0.0 )
            
            struct Attributes
            {
                float4 positionOS	: POSITION;
                float2 uv			: TEXCOORD0;                
				
            };

            struct Varyings
            {
				float4 positionHCS  : SV_POSITION;
                float2 uv           : TEXCOORD0;                
				float4 shadowPos	: TEXCOORD1;
            };

			// Create from shadowcaster.  
			TEXTURE2D(_posm_ShadowMap);       SAMPLER(sampler_posm_ShadowMap);			          
	        float4x4 POSM_MATRIX_VP;
			float4x4 POSM_MATRIX_V; 
			float4 posm_ShadowCamera_Parameter;
            float _DepthBias;
            float4 posm_Parameters; // w = 1/width;
            // (1,1000,0.00098, 0.00391)
            half PCF_FILTER_NN(half3 uvw0, half2 offsets[4])
            {
                half sum = 0;
                half3 uvw = uvw0;                
                for(int i = 0; i < 4; i++)
                {
                    uvw.xy = uvw0.xy + offsets[i];
                    half closestDepth = UNITY_SAMPLE_SHADOW_NN(_posm_ShadowMap, uvw);
                    sum += closestDepth;
                }
                return sum;
            }

            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;				
				half3 worldPos = TransformObjectToWorld(input.positionOS.xyz);				
				half4 clipPos = TransformWorldToHClip(worldPos);
				clipPos.z = clipPos.z - 0.1 * _DepthBias * clipPos.z;
				output.positionHCS = clipPos;				

				half4 shadowPos;
                shadowPos = mul(POSM_MATRIX_VP, worldPos); // LightSpace screenSpace
                float4 lightPos = mul(POSM_MATRIX_V, worldPos);
                shadowPos.z = lightPos.z* posm_ShadowCamera_Parameter.z - posm_ShadowCamera_Parameter.w + 1; // 深度值
				output.shadowPos = shadowPos;  // -1,1
                output.uv = input.uv;
				return output;
            }

            half4 frag(Varyings input) : SV_Target
            {          
                half2 uv = input.shadowPos.xy/2+0.5; // convert to [0,1]                        
                float depth = max(input.shadowPos.z,0.001) - 0.001;                                
                half3 uvw = half3(uv.xy, depth);                        
                float width = posm_Parameters.w*0.25;
                float dx =  width;   // w = 0.00391 = 4 * 1 / 1024; dx = 4.0 / width;
                float dy =  width;                
                
                half2 offsets_0[4] ={half2(-dx,dy), half2(dx,dy), half2(-dx,-dy), half2(dx,-dy)};

                half2 offsets_1[4] ={half2(0,0), half2(2*dx,0), half2(2*dx,2*dy), half2(0,2*dy)};
                half2 offsets_2[4] ={half2(0,0), half2(-2*dx,0), half2(-2*dx,2*dy), half2(0,2*dy)};
                half2 offsets_3[4] ={half2(0,0), half2(-2*dx,0), half2(-2*dx,-2*dy), half2(0,-2*dy)};
                half2 offsets_4[4] ={half2(0,0), half2(2*dx,0), half2(2*dx,-2*dy), half2(0,-2*dy)};

                half sumA = PCF_FILTER_NN(uvw,offsets_0);
                sumA = sumA / 4;
                half sumB = PCF_FILTER_NN(uvw,offsets_1) + PCF_FILTER_NN(uvw,offsets_2) + PCF_FILTER_NN(uvw,offsets_3) + PCF_FILTER_NN(uvw,offsets_4);
                sumB = sumB / 16;
                half sum = 0.5*sumA + 0.5*sumB;
                float4 color = pow(sum,0.40000001);
				 color.rgba = half4(input.uv.x,0.01,0,1);
                
                return color;                               
            }
            ENDHLSL
        }
    }
}