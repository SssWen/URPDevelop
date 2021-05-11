Shader "Custom/UnlitTexture"
{
    Properties
    {
        [MainColor] _BaseColor("BaseColor", Color) = (1,0.5,0,1)
        //[MainTexture] _BaseMap("BaseMap", 2D) = "white" {}
    }

    // Universal Render Pipeline subshader. If URP is installed this will be used.
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalRenderPipeline"}

        Pass
        {
            Tags { "LightMode"="UniversalForward" }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS   : POSITION;
                float2 uv           : TEXCOORD0;
            };

            struct Varyings
            {
                float2 uv           : TEXCOORD0;
                float4 positionHCS  : SV_POSITION;
            };

            TEXTURE2D(_ZorroShadowmapTexture);
            TEXTURE2D(_CameraColorTexture);
            SAMPLER(sampler_ZorroShadowmapTexture);
            SAMPLER(sampler_CameraColorTexture);
            half4 _BaseColor;
            half4 _MainColor;
            /*
            CBUFFER_START(UnityPerMaterial)
            float4 _BaseMap_ST;
            half4 _BaseColor;
            CBUFFER_END
			*/
            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                // OUT.uv = TRANSFORM_TEX(IN.uv, _BaseMap);
                OUT.uv = IN.uv;
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                //return SAMPLE_TEXTURE2D(_ZorroShadowmapTexture, sampler_ZorroShadowmapTexture, IN.uv) * _BaseColor;
                // return SAMPLE_TEXTURE2D(_CameraColorTexture, sampler_CameraColorTexture, IN.uv) * _BaseColor;
                return _BaseColor*IN.uv.x;
                // return  _BaseColor;
            }
            ENDHLSL
        }
    }


}