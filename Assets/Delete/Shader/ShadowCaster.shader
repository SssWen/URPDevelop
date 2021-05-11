Shader "NN4/ShadowCaster"
{
    Properties
    {
        
        _DepthBias("_DepthBias", float) = 0
        _DepthSlopeBias("_DepthSlopeBias", float) = -0.005
        _ShadowBias("_ShadowBias", float) = 0
        posm_ShadowCamera_Parameter("posm_ShadowCamera_Parameter", Vector) = (0.01,1.70942,0.58844,-0.00588)
        // x = near = 0.01
        // y = far = 1.70942
        // z = 1/far = 0.58844
        // w = near/far = -0.00588
        // size = 0.97
        // aspect 1:1 1024:1024
        // cameraPos : (0,-0.696,-1.245)
        // -(far + near) / (far - near) = -1.01
        // -2/(far-near) = -1.17

        // Projection matrix

        // 1/(aspect*size)  0       0                       0
        // 0                1/size  0                       0
        // 0                0       -2/(far - near)    -(far+near)/(far-near)
        // 0                0       0                       1

        //  P * V = VP ==>  P = VP * V(T);

        // 第三列改成符号相反.
        // -0.95298, 0.1371, 0.27025
        // 7.45058E-09, 0.8918, -0.45243
        // -0.30304, -0.43116, -0.84986

        // 0.00, -0.6956, -1.24477, 1.00


        // depthCamera.transform.eulerAngle = (26.9,162.4,0)
        // depthCamera.transform.position = (0.00, -0.6956, -1.24477)

    }
    SubShader
    {    		
		Pass
        {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ZWrite On
            ZTest LEqual
            Cull Off

            HLSLPROGRAM
            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 3.0
            
			struct appdata
            {
                float4 vertex : POSITION;                
                float3 normal : NORMAL;
            };

            struct v2f
            {                                
                float4 vertex : SV_POSITION;                
                float2 uv : TEXCOORD0;                
            };            

            float _DepthBias;
            float _DepthSlopeBias;
            float _ShadowBias;
            float4 posm_ShadowCamera_Parameter;
            v2f vert (appdata v)
            {
                v2f o;
                                
                half4 wPos = mul(unity_ObjectToWorld, v.vertex);
                o.vertex = mul(UNITY_MATRIX_VP,wPos);

                half depth =  mul(UNITY_MATRIX_V, wPos).z;
                depth = depth * (1 - _ShadowBias);
                depth = depth * posm_ShadowCamera_Parameter.z - posm_ShadowCamera_Parameter.w + 1;
                o.uv.x = depth;  //  -(UnityObjectToViewPos( v.vertex ).z * _ProjectionParams.w)  w = w = 1/far plane

                half3 normal = normalize(v.normal);
                half y = mul(UNITY_MATRIX_IT_MV[2],normal);
                y = abs(y) * _DepthSlopeBias + _DepthBias + _ShadowBias;
                o.uv.y = y;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {                
                fixed4 col = i.uv.x + i.uv.y;                             
                return col;
            }

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl"
            ENDHLSL
        }
    }
}