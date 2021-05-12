Shader "NN4/HIDDEN/BloomDownSample"
{
    Properties
    {
        _MainTex("MainTex",2D) = "white"{}
        _BloomThreshold("BloomThreshold",float)= 2.0
    }

    HLSLINCLUDE
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    struct Attributes
    {
        float4 positionOS : POSITION;
        float4 uv : TEXCOORD0;
    };

    struct Varyings
    {
        float4 positionCS : SV_POSITION;
        float4 uv1 : TEXCOORD0;
        float4 uv2 : TEXCOORD1;
    };

    sampler2D _MainTex;
    float4 _MainTex_TexelSize;
    float _BloomThreshold;

    Varyings vert(Attributes v)
    {
        Varyings o = (Varyings)0;

        VertexPositionInputs vertexInput = GetVertexPositionInputs(v.positionOS.xyz);
        o.positionCS = vertexInput.positionCS;
        o.uv1.xy = v.uv.xy + _MainTex_TexelSize.xy;
        o.uv1.zw = _MainTex_TexelSize.xy * float2(-1,1) + v.uv.xy;
        o.uv2.xy = _MainTex_TexelSize.xy * float2(1,-1) + v.uv.xy;
        o.uv2.zw = v.uv.xy - _MainTex_TexelSize.xy;
        return o;
    }

    float4 fragFirst(Varyings i): SV_Target
    {
        float3 baseColor = tex2D(_MainTex,i.uv1.xy);
        baseColor = min(baseColor,10);
        //一次叠加
        float3 addColor = tex2D(_MainTex,i.uv1.zw);
        addColor = min(addColor,10);    
        baseColor += addColor;
        //二次叠加
        addColor = tex2D(_MainTex,i.uv2.xy);
        addColor = min(addColor,10);           
        baseColor += addColor;
        //三次叠加
        addColor = tex2D(_MainTex,i.uv2.zw);
        addColor = min(addColor,10);           
        baseColor += addColor;
        baseColor = max(baseColor,0);
        baseColor *= 0.25;
        float finalAlpha = dot(baseColor,float3(0.298999995, 0.587000012, 0.114));
        finalAlpha -= _BloomThreshold;
        finalAlpha = max(finalAlpha,0);

        return float4(baseColor,finalAlpha);
    }

    float4 fragSecond(Varyings i): SV_Target
    {
        float4 baseColor = tex2D(_MainTex,i.uv1.xy);

        float4 addColor = tex2D(_MainTex,i.uv1.zw);
        baseColor += addColor;

        addColor = tex2D(_MainTex,i.uv2.xy);
        baseColor += addColor;

        addColor = tex2D(_MainTex,i.uv2.zw);
        baseColor += addColor;

        baseColor *= 0.25;
        return baseColor;
    }
    ENDHLSL

    SubShader
    {
        Pass
        {
            Name "FirstBloom"
            ZTest Off
            Cull Off
            ZWrite Off
            Fog{Mode Off}
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment fragFirst

            ENDHLSL
        }

        Pass
        {
            Name "SecondBloom"
            Tags{"LightMode" = "ForwardBase" "RenderType" = "Opaque"}
            Zwrite OFF
            Ztest OFF
            Cull OFF
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment fragSecond

            ENDHLSL
        }
    }
}