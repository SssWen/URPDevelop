Shader "Fur/Fur_Shader"
{
    Properties
    {     
        _Specular ("Specular", Color) = (1, 1, 1, 1)
        _Shininess ("Shininess[高光范围]", Range(0.01, 256.0)) = 8.0

        _FurColorTex ("FurColorTex[毛发]", 2D) = "white" { }
        _FurColor ("FurColor[毛发]", Color) = (1, 1, 1, 1)
        [NoScaleOffset]_MaskTex ("Mask[毛发遮罩]", 2D) = "white" { }     
        _LayerTex ("Fur Layer[毛发噪声图]", 2D) = "white" { }                
        [NoScaleOffset]_LayerTexColor ("FurLayerColor[噪声颜色]", 2D) = "white" { }

        _FurLength ("Fur Length", Range(0.0, 1)) = 0.5
        _FurAlpha ("Fur Alpha", Range(0.0, 0.5)) = 0.1
        _FurDensity ("Fur Density", Range(0, 4)) = 0.11
        _FurThinness ("Fur Thinness", Range(0.01, 10)) = 1
        _FurShading ("Fur Shading", Range(0.0, 1)) = 0.25
        
        _Gravity("Gravity Direction[重力方向]", Vector) = (0,-1,0,0)
		_GravityStrength("Gravity Strength", Range(0,1)) = 0.25

        _RimColor ("Rim Color", Color) = (0, 0, 0, 1)
        _RimPower ("Rim Power", Range(0.0, 8.0)) = 6.0
    }
    
    Category
    {

        Tags { "RenderType" = "Transparent" "IgnoreProjector" = "True" "Queue" = "Transparent" }
        Cull Off
        ZWrite On
        Blend SrcAlpha OneMinusSrcAlpha
        
        SubShader
        {
            
            Pass
            {
                CGPROGRAM
                #pragma vertex vert_base
                #pragma fragment frag_base
                #pragma target 3.0
                #include "Lighting.cginc"
                #include "UnityCG.cginc"

                fixed FURSTEP;

                fixed4 _Specular;//FurSpecularColor
                half _Shininess;

                // 毛皮固有色
                sampler2D _MainTex;
                half4 _MainTex_ST;

                // 毛发遮罩
                sampler2D _MaskTex;
                half4 _MaskTex_ST;

                // 毛发颜色
                sampler2D _FurColorTex;
                half4 _FurColorTex_ST;
                fixed4 _FurColor;


                sampler2D _LayerTex; //FurPattern
                half4 _LayerTex_ST;

                sampler2D _LayerTexColor;
                half4 _LayerTexColor_ST;

                fixed _FurLength;
                fixed _FurAlpha;

                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading; //FurShadow

                fixed4 _Gravity;
                fixed _GravityStrength;

                fixed4 _RimColor; //FurRimColor
                half _RimPower;

                struct v2f
                {
                    float4 pos: SV_POSITION;
                    half4 uv: TEXCOORD0;
                    float3 worldNormal: TEXCOORD1;
                    float3 worldPos: TEXCOORD2;    
                };

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    half3 direction = lerp(v.normal, _Gravity * _GravityStrength + v.normal * (1 - _GravityStrength), FURSTEP);
                    float3 P =  direction * _FurLength * FURSTEP;
                    // add mask calculate. 
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _FurColorTex); 
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _LayerTex);

                    float4 mask = tex2Dlod(_MaskTex,float4(o.uv.xy,0,0));    

                    P =  v.vertex.xyz + P * mask.r;
                    
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    
                    // o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    

                    
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

                    return o;
                }

                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);

                    fixed3 albedo = tex2D(_FurColorTex, i.uv.xy).rgb * _FurColor;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    //边缘光
                    half vdotn = 1.0 - saturate(dot(worldView, worldNormal));
                    fixed3 rim = _RimColor.rgb * saturate( 1-pow( 1-vdotn, _RimPower));

                    fixed3 noise = tex2D(_LayerTex, i.uv.zw * _FurThinness).rgb;
                    fixed3 layerColor = tex2D(_LayerTexColor, i.uv.zw * _FurThinness).rgb;
                    fixed3 noiseColor = layerColor*noise;
                    albedo = lerp(albedo,albedo*noiseColor,noise.r);

                    fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);

                    fixed3 color = ambient + diffuse + specular + rim;
                    fixed alpha = saturate(noise - _FurAlpha- (FURSTEP * FURSTEP) * _FurDensity);

                    return fixed4(color, alpha);
                }
                
                ENDCG
                
            }
        }
    }
}