// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "NN/SH"
{
    Properties
    {


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

                float3 normal  : NORMAL;
            };

            struct v2f
            {                
                float4 vertex : SV_POSITION;

			    float3 shlight: TEXCOORD4;
			    // float4 Test: TEXCOORD5;
			    
            };
            
   


            

            v2f vert (appdata v)
            {
                v2f o;                                                                                                               
                                
                float4 clipPos = TransformObjectToHClip(v.vertex.xyz);
              
                o.vertex = clipPos;


                float3 worldNormal = TransformObjectToWorldNormal(v.normal);  
	

                
                float3 shlight = SampleSHVertex(worldNormal);
                //  shlight = SampleSH(worldNormal);

                o.shlight = shlight;
                
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {	                                            
                return float4(i.shlight,1);
              
            }
            ENDHLSL
        }
    }
}
