Shader "CustomURP/Hair_URP_Albedo"
{
	Properties 
	{

		_MainTexT ("Diffuse (RGB) Alpha (A)", 2D) = "white" {}
		
		_MainColor ("Main Color", Color) = (1,1,1,1)
		_NormalScale("Normal Scale", Range(0, 10)) = 1

        _Cutoff ("Alpha Cut-Off Threshold", Range(0, 1)) = 0.5

	}
 	SubShader
    {
        Pass
        {
            Name "Base"
            Tags {"Queue"="Geometry" "RenderType" = "TransparentCutout" "RenderPipeline" = "UniversalPipeline" "LightMode" = "UniversalForward"}
            ZWrite On
            Cull off
       
            HLSLPROGRAM
            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"

            struct Attributes
            {
                float4 positionOS       : POSITION;
                float2 uv               : TEXCOORD0;                
            };

            struct Varyings
            {
                float2 uv        : TEXCOORD0;
                
                float4 vertex   : SV_POSITION;
   
            };                                                
            

            half4 _MainColor;            
            half _Cutoff;
            TEXTURE2D(_MainTexT);       SAMPLER(sampler_MainTexT);
            float4 _MainTexT_ST;
            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;

                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                output.vertex = vertexInput.positionCS;
                output.uv = TRANSFORM_TEX(input.uv, _MainTexT);                
                return output;
            }

            half4 frag(Varyings input) : SV_Target
            {                
                half4 mainColor = SAMPLE_TEXTURE2D(_MainTexT, sampler_MainTexT, input.uv);
                clip(mainColor.a -_Cutoff);
                half3 color = mainColor.rgb * _MainColor.rgb * _MainLightColor.rgb;                         				
                return half4(color, mainColor.a);
            }
            ENDHLSL
        } 
	
    }
}