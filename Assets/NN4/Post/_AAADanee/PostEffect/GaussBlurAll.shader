Shader "NN4/HIDDEN/GaussBlur"
{
    Properties
    {
        _MainTex("MainTex",2D) = "white"{}
        _BlurRadius("BlurRadius",Vector) = (0,0,0,0)
    }

    HLSLINCLUDE
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
    sampler2D _MainTex;
    sampler2D _Tex8;
    sampler2D _Tex16;
    sampler2D _Tex32;
    float2 _BlurRadius;
    float4 _MainTex_TexelSize;

    struct Attributes
    {
        float4 positionOS: POSITION;
        float4 uv : TEXCOORD0;
    };

    struct Varyings
    {
        float4 positionCS : SV_POSITION;
        float4 uv1 : TEXCOORD0;
        float4 uv2 : TEXCOORD1;
        float4 uv3 : TEXCOORD2;
    };

 
    Varyings vertFirst(Attributes v)
    {
        Varyings o = (Varyings)0;
        VertexPositionInputs vertexInput = GetVertexPositionInputs(v.positionOS.xyz);
        o.positionCS = vertexInput.positionCS;

        float temp = _MainTex_TexelSize.x * _BlurRadius.x * 5;
        o.uv2.z = temp + v.uv.x;

        float2 temp2 = float2(temp * -1,0);
        
        float2 temp3 = temp * float2(-2,2);
        o.uv1.zw = temp2 + v.uv.xy;

        o.uv1.xy = float2(temp3.x,0) + v.uv.xy;
        o.uv3.xy = float2(temp3.y + v.uv.x, v.uv.y);
        o.uv2.xyw = v.uv.xyy;
        o.uv3.zw = 0;
        return o;
    }

    Varyings vertSecond(Attributes v)
    {
        Varyings o = (Varyings)0;
        VertexPositionInputs vertexInput = GetVertexPositionInputs(v.positionOS.xyz);
        o.positionCS = vertexInput.positionCS;

        float temp = _MainTex_TexelSize.y * _BlurRadius.y;
        o.uv2.w = temp + v.uv.y;

        float temp2 = _MainTex_TexelSize.x * _BlurRadius.x;   
        float2 temp3 = float2(temp2,temp);

        o.uv1.xy = temp3 * float2(0,-2)  + v.uv.xy;
        o.uv1.zw = temp3 * float2(0,-1)  + v.uv.xy;               
        o.uv3.xy = temp3 * float2(0,2)  + v.uv.xy;
        o.uv2.xyz = v.uv.xyx;
        o.uv3.zw = 0;
        return o;
    }

    Varyings vertLast(Attributes v)
    {
        Varyings o = (Varyings)0;
        VertexPositionInputs vertexInput = GetVertexPositionInputs(v.positionOS.xyz);
        o.positionCS = vertexInput.positionCS;

        o.uv1.xy = v.uv.xy;
        o.uv1.zw = 0;
        return o;
    }

    float4 frag(Varyings i) : SV_Target
    {
        float4 baseColor = tex2D(_MainTex,i.uv1.zw);
        baseColor *= 0.241999999;
        //一次叠加
        float4 addColor = tex2D(_MainTex,i.uv1.xy);
        baseColor += addColor * 0.0890000015;
        //二次叠加
        addColor = tex2D(_MainTex,i.uv2.xy);
        baseColor += addColor * 0.338;
        //三次叠加
        addColor = tex2D(_MainTex,i.uv2.zw);
        baseColor += addColor * 0.241999999;
        //四次叠加
        addColor = tex2D(_MainTex,i.uv3.xy);
        baseColor += addColor * 0.0890000015;

        return baseColor;
    }

    float4 fragLast(Varyings i) : SV_Target
    {
        float4 baseColor = tex2D(_MainTex,i.uv1.xy);
        //第一次叠加
        float4 addColor = tex2D(_Tex8,i.uv1.xy);
        baseColor += addColor * 0.5;
        //第二次叠加
        addColor = tex2D(_Tex16,i.uv1.xy);
        baseColor += addColor * 0.25;
        //第三次叠加
        addColor = tex2D(_Tex32,i.uv1.xy);
        baseColor += addColor * 0.125;

        return baseColor;
    }
    ENDHLSL

    SubShader
    {
        Zwrite OFF    
        Ztest OFF
        Cull OFF
        Pass
        {
            Tags{"LightMode" = "UniversalForward" "RenderType" = "Opaque"}
            Name "firstGauss"
            HLSLPROGRAM
            #pragma vertex vertFirst
            #pragma fragment frag
            ENDHLSL
        }

        Pass
        {
            Tags{"LightMode" = "LightweightForward"}
            Name "SecondGauss"
            HLSLPROGRAM
            #pragma vertex vertSecond
            #pragma fragment frag
            ENDHLSL
        }
        
        Pass
        {
            Tags{"LightMode" = "SRPDefaultUnlit" "RenderType" = "Opaque"}
            Name "ThirdGauss"
            HLSLPROGRAM
            #pragma vertex vertLast
            #pragma fragment fragLast
            ENDHLSL
        }


    }
}