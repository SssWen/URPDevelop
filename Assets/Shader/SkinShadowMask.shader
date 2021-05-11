Shader "NN/SkinShadowMask"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _DepthBias ("_DepthBias", float) = 0.0
        
    }
    SubShader
    {
        //Tags { "RenderType"="Opaque"  "QUEUE" = "Geometry"}
		Tags { "RenderType" = "Opaque" }        
        Cull back
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            // coord.z 像素点距离 Light 的距离, tex2Dlod, 像素点屏幕uv 采样Shadowmap下的深度值.进行比较.
            #define UNITY_SAMPLE_SHADOW_NN(tex,coord) (coord.z >= tex2Dlod(tex,float4(coord.xy,0,0)) ? 1.0 : 0.0)// 在lightSpace 中比较深度值

            struct appdata
            {
                float4 vertex : POSITION;
                half2 uv : TEXCOORD0;
                float4 shadowPos :TEXCOORD1; // 3                   
            };

            struct v2f
            {
                half2 uv : TEXCOORD0;            
                float4 vertex : SV_POSITION;
                float4 shadowPos : TEXCOORD1;
   
            };                        
            sampler2D posm_ShadowMap; // Create from shadowcaster.
            float4 _MainTex_ST;            
	        float4x4 POSM_MATRIX_VP;
			float4x4 POSM_MATRIX_V; 
			float4 posm_ShadowCamera_Parameter;
            float _DepthBias;
            float4 posm_Parameters; // w = 1/width;
            // (1,1000,0.00098, 0.00391)
            float PCF_FILTER_NN(half3 uvw0, half2 offsets[4])
            {
                half sum = 0;
                half3 uvw = uvw0;                
                for(int i = 0; i < 4; i++)
                {
                    uvw.xy = uvw0.xy + offsets[i];
                    half closestDepth = UNITY_SAMPLE_SHADOW_NN(posm_ShadowMap, uvw);
                    sum += closestDepth;
                }
                return sum;
            }
            v2f vert (appdata v)
            {
                v2f o;
                float4 worldPos = mul(unity_ObjectToWorld, v.vertex);                
                float4 cPos = mul(UNITY_MATRIX_VP,worldPos);
                // cPos.z = cPos.z * (1 - 0.100000001 * _DepthBias);
                cPos.z = cPos.z  - 0.100000001 * _DepthBias * cPos.z;
                o.vertex = cPos;
                float4 shadowPos;
                shadowPos = mul(POSM_MATRIX_VP, worldPos); // LightSpace screenSpace
                float4 lightPos = mul(POSM_MATRIX_V, worldPos);
                shadowPos.z = lightPos.z* posm_ShadowCamera_Parameter.z - posm_ShadowCamera_Parameter.w + 1; // 深度值
				o.shadowPos = shadowPos;  // -1,1
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                // sample the texture
                half2 uv = i.shadowPos.xy/2+0.5; // convert to [0,1]                        
                float depth = max(i.shadowPos.z,0.001) - 0.001;
                half3 uvw = half3(uv.xy, depth);
                // float width = 1024;             
                // float dx = 1.0 / width;   // w = 0.00391 = 4 * 1 / 1024; dx = 4.0 / width;
                // float dy = 1.0 / width;                                
                //float width = posm_Parameters.w*0.25;
                float width = 0.00391*0.25;
                float dx =  width;   // w = 0.00391 = 4 * 1 / 1024; dx = 4.0 / width;
                float dy =  width;                
                half2 offsets_0[4] ={half2(-dx,dy), half2(dx,dy), half2(-dx,-dy), half2(dx,-dy)};                
                
                half2 offsets_1[4] ={half2(0,0), half2(2*dx,0), half2(2*dx,2*dy), half2(0,2*dy)};
                half2 offsets_2[4] ={half2(0,0), half2(-2*dx,0), half2(-2*dx,2*dy), half2(0,2*dy)};
                half2 offsets_3[4] ={half2(0,0), half2(-2*dx,0), half2(-2*dx,-2*dy), half2(0,-2*dy)};
                half2 offsets_4[4] ={half2(0,0), half2(2*dx,0), half2(2*dx,-2*dy), half2(0,-2*dy)};

                // float _depth;
                // _depth = tex2D(posm_ShadowMap,uv.xy + offsets_0[0]);
                // _depth = UNITY_SAMPLE_SHADOW_NN(posm_ShadowMap, uvw);

                // return float4(_depth,_depth,_depth,1);

                half sumA = PCF_FILTER_NN(uvw,offsets_0);
                sumA = sumA / 4;
// return float4(sumA,sumA,sumA,1);
                half sumB = PCF_FILTER_NN(uvw,offsets_1) + PCF_FILTER_NN(uvw,offsets_2) + PCF_FILTER_NN(uvw,offsets_3) + PCF_FILTER_NN(uvw,offsets_4);
                sumB = sumB / 16;
                half sum = 0.5*sumA + 0.5*sumB;
                float4 color = pow(sum,0.40000001);                   
				// color.rgba = half4(1,1,0,1);
                
                return color;                               
            }
            ENDCG
        }
    }
}


