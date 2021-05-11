Shader "CustomURP/Hair_URP_Base"
{
	Properties 
	{

		_MainTexT ("Diffuse (RGB) Alpha (A)", 2D) = "white" {}
        _BumpMap ("Normal Map", 2D) = "Black" {}
		_AnisoDir ("SpecShift(G),Spec Mask (B)", 2D) = "white" {}

		
		_MainColor ("Main Color", Color) = (1,1,1,1)
		_NormalScale("Normal Scale", Range(0, 10)) = 1
		_Specular ("Specular Amount", Range(0, 5)) = 1.0 
        _Cutoff ("Alpha Cut-Off Threshold", Range(0, 1)) = 0.5

		[Header(Spec1)]_SpecularColor ("Specular1 Color", Color) = (1,1,1,1)
		_SpecularMultiplier ("Specular1 Power", float) = 100.0	
		_PrimaryShift ( "Specular1 Shift", float) = 0.0

		[Header(Spec2)]_SpecularColor2 ("Specular2 Color", Color) = (0.5,0.5,0.5,1)
		_SpecularMultiplier2 ("Specular2 Power", float) = 100.0
		_SecondaryShift ( "Specular2 Shift", float) = .7

		[Header(Spec3)]_SpecularColor3 ("Specular3 Color", Color) = (0.5,0.5,0.5,1)
		_SpecularMultiplier3 ("Specular3 Power", float) = 100.0
		_ThirdShift ( "Specular3 Shift", float) = .7

	}
 	SubShader
    {
        // Tags {"Queue"="Transparent+5"}
        // Tags{"RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" "IgnoreProjector" = "True"}
        // Pass
        // {
        //     Name "Base"
        //     Tags {"RenderType" = "TransparentCutout" "RenderPipeline" = "UniversalPipeline" "LightMode" = "UniversalForward"}
        //     ZWrite On
        //     Cull back
       
        //     HLSLPROGRAM
        //     // Required to compile gles 2.0 with standard srp library
        //     #pragma prefer_hlslcc gles
        //     #pragma exclude_renderers d3d11_9x
        //     #pragma target 3.0
        //     #pragma vertex vert
        //     #pragma fragment frag

        //     #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        //     #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"

        //     struct Attributes
        //     {
        //         float4 positionOS       : POSITION;
        //         float2 uv               : TEXCOORD0;                
        //     };

        //     struct Varyings
        //     {
        //         float2 uv        : TEXCOORD0;
        //         float fogCoord  : TEXCOORD1;
        //         float4 vertex   : SV_POSITION;
   
        //     };
                        
            
        //     half _Brightness;
        //     half _Blur;

        //     half4 _MainColor;
        //     half _NormalScale;
        //     half _Cutoff;
        //     TEXTURE2D(_MainTexT);       SAMPLER(sampler_MainTexT);
        //     float4 _MainTexT_ST;
        //     Varyings vert(Attributes input)
        //     {
        //         Varyings output = (Varyings)0;

        //         VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
        //         output.vertex = vertexInput.positionCS;
        //         output.uv = TRANSFORM_TEX(input.uv, _MainTexT);                

        //         return output;
        //     }

        //     half4 frag(Varyings input) : SV_Target
        //     {

        //         half2 uv = input.uv;
        //         half4 mainColor = SAMPLE_TEXTURE2D(_MainTexT, sampler_MainTexT, uv);
        //         half3 color = mainColor.rgb * _MainColor.rgb;
        //         half alpha = mainColor.a;
        //         clip(alpha -_Cutoff);
				
        //         return half4(color, alpha);
        //     }
        //     ENDHLSL
        // }
        Pass
        {
            Name "Specular"
            Tags{ "Queue"="Transparent"   "RenderPipeline" = "UniversalPipeline"  "LightMode" = "SRPDefaultUnlit" } 

            ZWrite Off
            Cull Off
		    Blend SrcAlpha OneMinusSrcAlpha
            HLSLPROGRAM            
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 3.0
            #pragma shader_feature _NORMALMAP

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"
            half StrandSpecular ( half3 T, half3 V, half3 L, half exponent)
			{
				half3 H = normalize(L + V);
				half dotTH = dot(T, H);
				half sinTH = sqrt(1 - dotTH * dotTH);
				half dirAtten = smoothstep(-1, 0, dotTH);
				return dirAtten * pow(sinTH, exponent);
			}
			
			half MHY_StrandSpecular ( half3 T, half3 V, half3 L, half exponent, float strength)
			{
				half3 H = normalize(L + V);
				half dotTH = dot(T, H);
				half sinTH = sqrt(1 - dotTH * dotTH);
				half dirAtten = smoothstep(-1, 0, dotTH);
				return dirAtten * pow(sinTH, exponent) * strength;
			}			
			// Kajiya-kay diffuse term sin(T,L) looks too bright without proper self-shadowing. used a tweaked N.L term;
			half3 Base_ShiftTangent ( half3 T, half3 N, half shift)
			{
				return normalize(T + shift * N); // 将高光沿着头发的长度方向进行移动，即修改切线方向
			}
            struct Attributes
            {
                float4 positionOS    : POSITION;
                float3 normalOS      : NORMAL;
                float4 tangentOS     : TANGENT;
                float2 texcoord      : TEXCOORD0;
                
            };

            struct Varyings
            {                
                float4 uv        : TEXCOORD0;
                float3 posWS     : TEXCOORD1;    // xyz: posWS                
                float4  normal                  : TEXCOORD2;
                float4  tangent                  : TEXCOORD3;
                float4  bitangent                  : TEXCOORD4;
                float3 viewDir                  : TEXCOORD5;
                float4 positionCS               : SV_POSITION;
   
            }; 

            half _Cutoff;
            TEXTURE2D(_AnisoDir);       SAMPLER(sampler_AnisoDir);
            float4 _AnisoDir_ST;

            half _NormalScale;

            TEXTURE2D(_MainTexT);       SAMPLER(sampler_MainTexT);
            float4 _MainTexT_ST;

            float4 _BumpMap_ST;
            half4 _MainColor;
            half _SpecularMultiplier, _PrimaryShift, _ThirdShift, _Specular, _SecondaryShift, _SpecularMultiplier2, _SpecularMultiplier3;
			half4 _SpecularColor, _SpecularColor2, _SpecularColor3;
			          
            #pragma vertex vert
            #pragma fragment frag
            Varyings vert (Attributes input) // T N V L AO
			{
				Varyings output = (Varyings)0;
                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);
                VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);
                half3 viewDirWS = normalize(GetCameraPositionWS() - vertexInput.positionWS);
                // half fogFactor = ComputeFogFactor(vertexInput.positionCS.z);

                output.uv.xy = TRANSFORM_TEX(input.texcoord, _MainTexT);
                output.uv.zw = TRANSFORM_TEX(input.texcoord, _BumpMap);
                output.posWS.xyz = vertexInput.positionWS;
                output.positionCS = vertexInput.positionCS;

                output.normal = half4(normalInput.normalWS, viewDirWS.x);
                output.tangent = half4(normalInput.tangentWS, viewDirWS.y);
                output.bitangent = half4(normalInput.bitangentWS, viewDirWS.z);				

				return output;
			}

			half4 frag (Varyings input) : SV_Target
			{
				half4 albedo = SAMPLE_TEXTURE2D(_MainTexT, sampler_MainTexT, input.uv.xy);
             
				half3 diffuseColor = albedo.rgb * _MainColor.rgb;			
                 
                half3 normalTS = SampleNormal(input.uv.zw, TEXTURE2D_ARGS(_BumpMap, sampler_BumpMap), _NormalScale);
                // half3 normalTS = TEXTURE2D_ARGS(_BumpMap, sampler_BumpMap), _NormalScale);
    
                half3 worldNormal = TransformTangentToWorld(normalTS,
                    half3x3(input.tangent.xyz, input.bitangent.xyz, input.normal.xyz));            
                worldNormal = NormalizeNormalPerPixel(worldNormal);                                																
                

				// half3 worldLightDir = normalize(_MainLightPosition.xyz - input.posWS.xyz);
                half3 worldLightDir = _MainLightPosition.xyz;

                half3 worldViewDir = normalize(GetCameraPositionWS() - input.posWS.xyz);
                
                // half3 worldViewDir = half3(input.normal.w, input.tangent.w, input.bitangent.w);
                // worldViewDir = SafeNormalize(worldViewDir);
				
                half3 spec = SAMPLE_TEXTURE2D(_AnisoDir, sampler_AnisoDir, input.uv).rgb;

				//计算切线方向的偏移度
				half shiftTex = spec.g;
				half3 t1 = Base_ShiftTangent(input.bitangent.xyz, worldNormal, _PrimaryShift + shiftTex);
				half3 t2 = Base_ShiftTangent(input.bitangent.xyz, worldNormal, _SecondaryShift + shiftTex);
				half3 t3 = Base_ShiftTangent(input.bitangent.xyz, worldNormal, _ThirdShift + shiftTex);

				half3 spec1 = StrandSpecular(t1, worldViewDir, worldLightDir, _SpecularMultiplier)* _SpecularColor;
				half3 spec2 = StrandSpecular(t2, worldViewDir, worldLightDir, _SpecularMultiplier2)* _SpecularColor2;
				half3 spec3 = StrandSpecular(t3, worldViewDir, worldLightDir, _SpecularMultiplier3)* _SpecularColor3;

				half4 finalColor = half4(0,0,0,0);
				finalColor.rgb = diffuseColor + spec1 * _Specular;                    
				finalColor.rgb += spec2 * _SpecularColor2 * spec.b * _Specular;//第二层高光，spec.b用于添加噪点
				finalColor.rgb += spec3 * spec.b * _Specular;
				finalColor.rgb *= _MainLightColor.rgb;
				finalColor.a = albedo.a;                

				return finalColor;
			};                        
            ENDHLSL
        }
	
    }
}