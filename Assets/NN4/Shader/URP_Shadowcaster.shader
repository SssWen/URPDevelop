Shader "Custom/URP_Shadowcaster"
{
    Properties
    {
        _DepthBias("_DepthBias", Float) = 0
        _DepthSlopeBias("_DepthSlopeBias", Float) = -0.005
        _ShadowBias("_ShadowBias", Float) = 0
        posm_ShadowCamera_Parameter("posm_ShadowCamera_Parameter", Vector) = (0.01,1.70942,0.58844,-0.00588)
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipelinpute"="UniversalRenderPipelinpute"}

        Pass
        {
            Tags { "LightMode"="UniversalForward" }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			

            struct Attributes
            {
                float4 positionOS	: POSITION;
                float2 uv			: TEXCOORD0;
				float3 normal		: NORMAL;
            };

            struct Varyings
            {
                float2 uv           : TEXCOORD0;
                float4 positionHCS  : SV_POSITION;
            };
			
			float _DepthBias;
            float _DepthSlopeBias;
            float _ShadowBias;
            float4 posm_ShadowCamera_Parameter;


            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;				
				half3 positionWS = TransformObjectToWorld(input.positionOS.xyz);				
				output.positionHCS = TransformWorldToHClip(positionWS);

				half depth = TransformWorldToView(positionWS).z;
				depth = depth * (1 - _ShadowBias);
                depth = depth * posm_ShadowCamera_Parameter.z - posm_ShadowCamera_Parameter.w + 1;
				output.uv.x = depth;
				
                half3 normal = normalize(input.normal);
				half y = mul(UNITY_MATRIX_IT_MV[2],normal);
                y = abs(y) * _DepthSlopeBias + _DepthBias + _ShadowBias;
                output.uv.y = y;

                return output;
            }

            half4 frag(Varyings input) : SV_Target
            {          
				half4 col = input.uv.x + input.uv.y;
				//col.r = input.uv.x;
                return col;
            }
            ENDHLSL
        }
    }
}