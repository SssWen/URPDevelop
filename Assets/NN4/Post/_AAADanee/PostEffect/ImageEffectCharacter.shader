Shader "NN4/HIDDEN/ImageEffectCharacter"
{
    Properties
    {
        _MainTex("MainTex",2D) = "white"{}
        _CurveTex("CurveTex",2D) = "white"{}
        _BloomParameter("BloomParameter",vector) = (2,1,0.2,0.3)
        _Gamma("Gamma",float) = 0.66667
        _MaxLuminance("MaxLuminance",vector) = (0.99831,1.00169,0,0)
    }
        SubShader
        {
            Pass
            {
                Tags{"LightMode" = "ForwardBase" "RenderType" = "TransParent"}
                Blend One OneMinusSrcAlpha
                HLSLPROGRAM
                #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
                #pragma vertex vert
                #pragma fragment frag
                sampler2D _MainTex;
                sampler2D _BloomTex;
                sampler2D _CurveTex;
                float4 _BloomParameter;
                float _Gamma;
                float2 _MaxLuminance;

                struct Attributes
                {
                    float4 positionOS : POSITION;
                    float4 uv : TEXCOORD0;
                };

                struct Varyings
                {
                    float4 positionCS : SV_POSITION;
                    float4 uv : TEXCOORD0;
                };

                Varyings vert(Attributes v)
                {
                    Varyings o = (Varyings)0;

                    VertexPositionInputs vertexInput = GetVertexPositionInputs(v.positionOS.xyz);
                    o.positionCS = vertexInput.positionCS;
                    o.uv.xy = v.uv.xy;
                    return o;
                }

                float4 frag(Varyings i) :SV_Target
                {   
                    //1.把画面压暗
                    float4 bloomColor = tex2D(_BloomTex,i.uv.xy);
                    float temp = dot(bloomColor.xyz,float3(0.298999995, 0.587000012, 0.114));
                    float temp2 = max(temp,0.00100000005);
                    temp = temp2 - _BloomParameter.z; //z值拿来控制身体部分亮度
                    temp = max(temp,0);
                    float3 finalCol = bloomColor.xyz * temp;
                    bloomColor.xyz = bloomColor.w * bloomColor.xyz;
                    finalCol = finalCol/temp2;

                    //叠加bloom
                    float4 oriCol = tex2D(_MainTex,i.uv.xy);
                    oriCol = max(oriCol,0);
                    finalCol = finalCol * _BloomParameter.w + oriCol; 
                    finalCol = bloomColor.xyz * _BloomParameter.y + finalCol;

                    //提亮画面
                    float dotFinalCol = dot(finalCol,float3(0.298999995, 0.587000012, 0.114));
                    dotFinalCol = max(dotFinalCol,0.00100000005);
                    float2 uv = float2(dotFinalCol * _MaxLuminance.y,0.5);//y拿来控制亮度范围，沿着边缘
                    float CurveCol = tex2D(_CurveTex,uv).x;
                    //这里就是采样之后和NN表现不一致
                    //背景开启了纯色，看起来是正常的
                    
                    CurveCol = CurveCol/ dotFinalCol;
                    finalCol *= CurveCol;
                    finalCol = pow(finalCol,_Gamma);

                    //linear to NN gama
#if !defined(UNITY_NO_LINEAR_COLORSPACE)
    finalCol = pow(finalCol,2.2);  
#endif
                    finalCol = min(finalCol,1);
                    return float4(finalCol,oriCol.w);
                }
                ENDHLSL
            }
        }
}









