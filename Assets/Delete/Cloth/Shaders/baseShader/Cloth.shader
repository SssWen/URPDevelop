Shader "CustomURP/Cloth"
{
    Properties
    {
        // Specular vs Metallic workflow
        [HideInInspector] _WorkflowMode("WorkflowMode", Float) = 1.0

        [MainColor] _BaseColor("Color", Color) = (1,1,1,1)
        [MainTexture] _BaseMap("Albedo", 2D) = "white" {}

        _Cutoff("Alpha Cutoff", Range(0.0, 1.0)) = 0.5

        _Smoothness("Smoothness", Range(0.0, 1.0)) = 0.5
        _GlossMapScale("Smoothness Scale", Range(0.0, 1.0)) = 1.0
        _SmoothnessTextureChannel("Smoothness texture channel", Float) = 0

        [Gamma] _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
        _MetallicGlossMap("Metallic", 2D) = "white" {}

        _SpecColor("Specular", Color) = (0.2, 0.2, 0.2)
        _SpecGlossMap("Specular", 2D) = "white" {}

        [ToggleOff] _SpecularHighlights("Specular Highlights", Float)  = 1.0
        [ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1.0

        _BumpScale("Scale", Float) = 1.0
        _BumpMap("Normal Map", 2D) = "bump" {}

        _OcclusionStrength("Strength", Range(0.0, 1.0)) = 1.0
        _OcclusionMap("Occlusion", 2D) = "white" {}

        _EmissionColor("Color", Color) = (0,0,0)
        _EmissionMap("Emission", 2D) = "white" {}

        // Blending state
        [HideInInspector] _Surface("__surface", Float) = 0.0
        [HideInInspector] _Blend("__blend", Float) = 0.0
        [HideInInspector] _AlphaClip("__clip", Float) = 0.0
        [HideInInspector] _SrcBlend("__src", Float) = 1.0
        [HideInInspector] _DstBlend("__dst", Float) = 0.0
        [HideInInspector] _ZWrite("__zw", Float) = 1.0
        [HideInInspector] _Cull("__cull", Float) = 2.0

        _ReceiveShadows("Receive Shadows", Float) = 1.0
        // Editmode props
        [HideInInspector] _QueueOffset("Queue offset", Float) = 0.0

        // ObsoleteProperties
        [HideInInspector] _MainTex("BaseMap", 2D) = "white" {}
        [HideInInspector] _Color("Base Color", Color) = (1, 1, 1, 1)
        [HideInInspector] _GlossMapScale("Smoothness", Float) = 0.0
        [HideInInspector] _Glossiness("Smoothness", Float) = 0.0
        [HideInInspector] _GlossyReflections("EnvironmentReflections", Float) = 0.0

    // Rim        
        [ToggleOff] _RimAlphaOn("RimAlphaOn", Float)  = 0.0        
        _RimAlphaMin ("Edge Alpha Min", Range(0, 1)) = 0
        _RimAlphaMax ("Edge Alpha Max", Range(0, 1)) = 1
        _RimAlphaEnhance ("Edge Alpha Intensity", Range(0, 1)) = 0
        _Transparency ("Transparency", Range(0, 1)) = 1
        _MinTransparency ("MinTransparency", Range(0, 1)) = 0
    // Rim

    // RimLight
        [ToggleOff] _RimLightOn("RimLightOn", Float)  = 0.0
        _RimLightMin ("RimLight Min", Range(0, 1)) = 0
        _RimLightMax ("RimLight Max", Range(0, 1)) = 1        
        [HDR]_RimLightColor ("Edge Light Color", Color) = (1,1,1,1)
    // RimLight

    // TCP_RIM
    	[ToggleOff] _TCP_Rim_On("Stylized Fresnel", Float) = 0
		_TCP_RimColor("Rim Color (RGB)", Color) = (1,1,1,1)
		_TCP_RimStrength("Rim Strength", Range(0, 2)) = 0.5
		_TCP_RimMin("Rim Min", Range(0, 0.99)) = 0.6
		_TCP_RimMax("Rim Max", Range(0, 0.99)) = 0.7

    	[ToggleOff] _TCP_RimOffset_On("Light Offset", float) = 0
		_TCP_RimOffsetX("Rim OffsetX", Range(-2, 2)) = 0
		_TCP_RimOffsetY("Rim OffsetY", Range(-2, 2)) = 0
		_TCP_RimOffsetZ("Rim OffsetZ", Range(-2, 2)) = 0
    // TCP_RIM
    // SharpChange
        [ToggleOff] _SharpLightChangeOn("SharpLightChange", Float)  = 0.0
        [HDR]_HighLightColor ("HighLightColor", Color) = (1,1,1,1)
        [HDR]_ShadowLightColor ("ShadowColor", Color) = (0,0,0,1)
        
        [ToggleOff] _WrapLightingOn("WrapLighting", Float)  = 0.0
        _Threshold1 ("Threshold1", Range(0, 1)) = 0.4
        _Threshold2 ("Threshold2", Range(0, 1)) = 0.8
        _AttenuationControl ("AttenuationControl", Range(-1, 5)) = 1
    // SharpChange

    // Anistropic
        [ToggleOff] _AnistropicOn("Anistropic", Float)  = 0.0
        _SpecularColor("SpecularColor", Color) = (1,1,1,1)
        _RoughnessX ("RoughnessX", Range(0.01, 2)) = 0.01
        _RoughnessY ("RoughnessY", Range(0.01, 2)) = 0.01
        _LightDirX ("LightDirX", Range(-1, 1)) = 0
        _LightDirY ("LightDirY", Range(-1, 1)) = 0
        _LightDirZ ("LightDirZ", Range(-1, 1)) = 0
        _AnisNoiseTex ("AnisNoiseTex", 2D) = "white"{}
        _ShiftX ("RoughnessX", Range(0.01, 2)) = 0.01
        _ShiftY ("RoughnessY", Range(0.01, 2)) = 0.01
        _Offset ("Offset", Range(-3, 3)) = 0.01
        _Rotate ("Rotate", Range(-3, 3)) = 0
    // Anistropic

    // Layer
        _Layer0Tex("Layer0Tex", 2D) = "black"{}		
        _Layer0Normal("Layer0Normal", 2D) = "black"{}
        _Layer0NormalScale("Layer0NormalScale", float) = 1        
        [HDR]_Layer0Color("Layer1Color", Color) = (1,1,1,1)
        _Layer0Smoothness("Layer0Smoothness", Range(-1, 1)) = 0
		_Layer0Metallic("Layer0Metallic", Range(-1, 1)) = 0
        [Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer0UVSet("Layer0UVSet", float) = 0
        [Enum(Blend,0,Cover,1)] _Layer0NormalMode("Layer0NormalMode", float) = 0

		_Layer1Tex("Layer1Tex", 2D) = "black"{}		
		_Layer1Normal("Layer1Normal", 2D) = "bump"{}
		_Layer1NormalScale("Layer1NormalScale", float) = 1
		[HDR]_Layer1Color("Layer1Color", Color) = (1,1,1,1)
		_Layer1Smoothness("Layer1Smoothness", Range(-1, 1)) = 0
		_Layer1Metallic("Layer1Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer1UVSet("Layer1UVSet", float) = 0        
        [Enum(Blend,0,Cover,1)] _Layer1NormalMode("Layer1NormalMode", float) = 0
        _Layer1Cutoff("Layer1Alpha Cutoff", Range(0.0, 1.0)) = 0.5

        _Layer2Tex("Layer2Tex", 2D) = "black"{}		
		_Layer2Normal("Layer2Normal", 2D) = "bump"{}
		_Layer2NormalScale("Layer2NormalScale", float) = 1
		[HDR]_Layer2Color("Layer2Color", Color) = (1,1,1,1)
		_Layer2Smoothness("Layer2Smoothness", Range(-1, 1)) = 0
		_Layer2Metallic("Layer2Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer2UVSet("Layer2UVSet", float) = 0
        [Enum(Blend,0,Cover,1)] _Layer2NormalMode("Layer2NormalMode", float) = 0

        _Layer3Tex("Layer3Tex", 2D) = "black"{}		
		_Layer3Normal("Layer3Normal", 2D) = "bump"{}
		_Layer3NormalScale("Layer3NormalScale", float) = 1
		[HDR]_Layer3Color("Layer3Color", Color) = (1,1,1,1)
		_Layer3Smoothness("Layer3Smoothness", Range(-1, 1)) = 0
		_Layer3Metallic("Layer3Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer3UVSet("Layer3UVSet", float) = 0
        [Enum(Blend,0,Cover,1)] _Layer3NormalMode("Layer3NormalMode", float) = 0

        _Layer4Tex("Layer4Tex", 2D) = "black"{}		
		_Layer4Normal("Layer4Normal", 2D) = "bump"{}
		_Layer4NormalScale("Layer4NormalScale", float) = 1
		[HDR]_Layer4Color("Layer4Color", Color) = (1,1,1,1)
		_Layer4Smoothness("Layer4Smoothness", Range(-1, 1)) = 0
		_Layer4Metallic("Layer4Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer4UVSet("Layer4UVSet", float) = 0
        [Enum(Blend,0,Cover,1)] _Layer4NormalMode("Layer4NormalMode", float) = 0

        _Layer5Tex("Layer5Tex", 2D) = "black"{}		
		_Layer5Normal("Layer5Normal", 2D) = "bump"{}
		_Layer5NormalScale("Layer5NormalScale", float) = 1
		[HDR]_Layer5Color("Layer5Color", Color) = (1,1,1,1)
		_Layer5Smoothness("Layer5Smoothness", Range(-1, 1)) = 0
		_Layer5Metallic("Layer5Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer5UVSet("Layer5UVSet", float) = 0
        [Enum(Blend,0,Cover,1)] _Layer5NormalMode("Layer5NormalMode", float) = 0

        _Layer6Tex("Layer6Tex", 2D) = "black"{}		
		_Layer6Normal("Layer6Normal", 2D) = "bump"{}
		_Layer6NormalScale("Layer6NormalScale", float) = 1
		[HDR]_Layer6Color("Layer6Color", Color) = (1,1,1,1)
		_Layer6Smoothness("Layer6Smoothness", Range(-1, 1)) = 0
		_Layer6Metallic("Layer6Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer6UVSet("Layer6UVSet", float) = 0
        [Enum(Blend,0,Cover,1)] _Layer6NormalMode("Layer6NormalMode", float) = 0

        _Layer7Tex("Layer7Tex", 2D) = "black"{}		
		_Layer7Normal("Layer7Normal", 2D) = "bump"{}
		_Layer7NormalScale("Layer7NormalScale", float) = 1
		[HDR]_Layer7Color("Layer7Color", Color) = (1,1,1,1)
		_Layer7Smoothness("Layer7Smoothness", Range(-1, 1)) = 0
		_Layer7Metallic("Layer7Metallic", Range(-1, 1)) = 0
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _Layer7UVSet("Layer7UVSet", float) = 0      
        [Enum(Blend,0,Cover,1)] _Layer7NormalMode("Layer7NormalMode", float) = 0
    // Layer

    // Sparkle 		
        [ToggleOff] _SparkleOn("SparkleOn", Float)  = 0.0
		_FlashTex("FlashTex(R)", 2D) = "White"{}
		[NoScaleOffset]_SparkleNoiseTex("SparkleNoiseTex(RGB)", 2D) = "White"{}
        [HDR]_FlashColor1("FlashColor1", Color) = (1,1,1,1)
		[HDR]_FlashColor2("FlashColor2", Color) = (1,1,1,1)
		_RadiusRandom("Radius Random", Range(1, 10)) = 5
		_DeleteSmall("Delete Small", Range(0, 1)) = 0
		_DeleteRandom("Delete Random", Range(0, 1)) = 0
		_ColorRandom("Color Random", Range(0, 1)) = 0.2
		_OffsetRandom("Offset Random", Range(0, 1)) = 1

		_FlashZone("FlashZone", Range(-1, 1)) = 1
		_FlashMin("FlashMin", Range(0, 0.1)) = 0
		_FlashSpeed("FlashSpeed", Range(0, 10)) = 3
		_DarkTime("DarkTime", Range(0,100)) = 10

		_FlashMetallic("FlashMetallic", Range(0, 1)) = 0.1
		_FlashSmoothness("FlashSmoothness", Range(0, 1)) = 0.9
		_RandomSeed("RandomSeed", Range(0, 10)) = 0

		_DensityTex("DensityTex(R)", 2D) = "White"{}
		_Density("Density", float) = 0
		_DensityCtrl("DensityCtrl", Range(0, 1)) = 0.5
		_DensitySmooth("DensitySmooth", Range(0, 2)) = 1
		[Enum(UV0,0, UV1,1, UV2,2, UV3,3)] _FlashUVSet("FlashUVSet", float) = 0
    // Sparkle

        // reflection
        _ReflectionTex("ReflectionTex", CUBE) = "white" {}        
        _Brightness("Brightness", Range(0, 20)) = 1
        _YRotation("YRotation", Range(0, 360)) = 1
    }

    SubShader
    {
        // Universal Pipeline tag is required. If Universal render pipeline is not set in the graphics settings
        // this Subshader will fail. One can add a subshader below or fallback to Standard built-in to make this
        // material work with both Universal Render Pipeline and Builtin Unity Pipeline
        Tags{"RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" "IgnoreProjector" = "True"}
        LOD 300

        // ------------------------------------------------------------------
        //  Forward pass. Shades all light in a single pass. GI + emission + Fog
        Pass
        {
            // Lightmode matches the ShaderPassName set in UniversalRenderPipeline.cs. SRPDefaultUnlit and passes with
            // no LightMode tag are also rendered by Universal Render Pipeline
            Name "ForwardLit"
            Tags{"LightMode" = "UniversalForward"}

            Blend[_SrcBlend][_DstBlend]
            ZWrite[_ZWrite]
            // ZWrite On
            Cull[_Cull]

            HLSLPROGRAM
            // Required to compile gles 2.0 with standard SRP library
            // All shaders must be compiled with HLSLcc and currently only gles is not using HLSLcc by default
            // Unity Keywards count limit:384 global keywords, plus 64 local keywords.

            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 3.5

            // -------------------------------------  multi_complie_local --
            // Material Keywords
            #pragma shader_feature _NORMALMAP
            #pragma shader_feature _ALPHATEST_ON            
            #pragma shader_feature _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _EMISSION
            #pragma shader_feature _METALLICSPECGLOSSMAP
            #pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature _OCCLUSIONMAP

            #pragma shader_feature _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature _ENVIRONMENTREFLECTIONS_OFF
            #pragma shader_feature _SPECULAR_SETUP
            #pragma shader_feature _RECEIVE_SHADOWS_OFF
            
            #pragma shader_feature _LAYER_0_TEX
            #pragma shader_feature _LAYER_1_TEX
            #pragma shader_feature _LAYER_2_TEX
			#pragma shader_feature _LAYER_3_TEX
			#pragma shader_feature _LAYER_4_TEX
			#pragma shader_feature _LAYER_5_TEX
			#pragma shader_feature _LAYER_6_TEX
			#pragma shader_feature _LAYER_7_TEX		          
            
            // 56 = 8*7
            #pragma shader_feature_local _LAYER_0_NORMAL
            #pragma shader_feature_local _LAYER_1_NORMAL
            #pragma shader_feature_local _LAYER_2_NORMAL
			#pragma shader_feature_local _LAYER_3_NORMAL
			#pragma shader_feature_local _LAYER_4_NORMAL
			#pragma shader_feature_local _LAYER_5_NORMAL
			#pragma shader_feature_local _LAYER_6_NORMAL
			#pragma shader_feature_local _LAYER_7_NORMAL
                                    
            #pragma shader_feature_local _Layer0UVSet_0 _Layer0UVSet_1 _Layer0UVSet_2 _Layer0UVSet_3
			#pragma shader_feature_local _Layer1UVSet_0 _Layer1UVSet_1 _Layer1UVSet_2 _Layer1UVSet_3
			#pragma shader_feature_local _Layer2UVSet_0 _Layer2UVSet_1 _Layer2UVSet_2 _Layer2UVSet_3
			#pragma shader_feature_local _Layer3UVSet_0 _Layer3UVSet_1 _Layer3UVSet_2 _Layer3UVSet_3
			#pragma shader_feature_local _Layer4UVSet_0 _Layer4UVSet_1 _Layer4UVSet_2 _Layer4UVSet_3
			#pragma shader_feature_local _Layer5UVSet_0 _Layer5UVSet_1 _Layer5UVSet_2 _Layer5UVSet_3
			#pragma shader_feature_local _Layer6UVSet_0 _Layer6UVSet_1 _Layer6UVSet_2 _Layer6UVSet_3
			#pragma shader_feature_local _Layer7UVSet_0 _Layer7UVSet_1 _Layer7UVSet_2 _Layer7UVSet_3
            
            #pragma shader_feature_local _Layer0NormalMode_0 _Layer0NormalMode_1
            #pragma shader_feature_local _Layer1NormalMode_0 _Layer1NormalMode_1
            #pragma shader_feature_local _Layer2NormalMode_0 _Layer2NormalMode_1
            #pragma shader_feature_local _Layer3NormalMode_0 _Layer3NormalMode_1
            #pragma shader_feature_local _Layer4NormalMode_0 _Layer4NormalMode_1
            #pragma shader_feature_local _Layer5NormalMode_0 _Layer5NormalMode_1
            #pragma shader_feature_local _Layer6NormalMode_0 _Layer6NormalMode_1
            #pragma shader_feature_local _Layer7NormalMode_0 _Layer7NormalMode_1
            
            // 10
            #pragma shader_feature _SPARKLE_ON
            #pragma shader_feature _REFLECTION_ON
            #pragma shader_feature _RIM_ALPHA_ON
            #pragma shader_feature _RIM_LIGHT_ON
            #pragma shader_feature _ANISTROPIC_ON
            #pragma shader_feature _ANIS_NOISE_TEX

            #pragma shader_feature _SHARPCHANGE_ON // SharpChange
            #pragma shader_feature _WRAPLIGHTING_ON // WrapLighting
            #pragma shader_feature _TCP_RIM_ON // TCP_Rim
            #pragma shader_feature _TCP_RIMOFFSET_ON // TCP_Rim_Offset
            
            // #pragma shader_feature_local _BLINEPHONG_ON // BlinnPhong

            // #pragma shader_feature_local _RIM_ON 
            // #pragma shader_feature_local SPECULAR_FADING Rim  TRANSPARENT_ZWRITE BKG2_UV1 TEX_PATTERN_NORMAL ANISOTROPIC_SPEC TEX_PATTERN_MAT PATT_UV1 TEX_PATTERN_NORMAL
            // RIM_LIGHT TEX_BKG_TINT TEX_BKG_NORMAL BKG2_UV1 ANISOTROPIC_SPEC
            

            // -------------------------------------
            // Universal Pipeline keywords
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE

            // -------------------------------------
            // Unity defined keywords // strip lightmap
            #pragma multi_compile_fog

            // --------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #pragma vertex Cloth_LitPassVertex
            #pragma fragment Cloth_LitPassFragment
            
            // UV,metallic,smoothness,normal,layer			
            #define ANISOTROPIC 1            
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Tools_URP.cginc"
            // Attributes,Varyings			
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ClothLitForwardPass.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "ShadowCaster"
            Tags{"LightMode" = "ShadowCaster"}

            ZWrite On
            ZTest LEqual
            Cull[_Cull]

            HLSLPROGRAM
            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 3.5

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature _ALPHATEST_ON

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl"
            ENDHLSL
        }

        Pass
        {
            Name "DepthOnly"
            Tags{"LightMode" = "DepthOnly"}

            ZWrite On
            ColorMask 0
            Cull[_Cull]

            HLSLPROGRAM
            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 3.5

            #pragma vertex DepthOnlyVertex
            #pragma fragment DepthOnlyFragment

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature _ALPHATEST_ON
            #pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/DepthOnlyPass.hlsl"
            ENDHLSL
        }

        // // This pass it not used during regular rendering, only for lightmap baking.
        // Pass
        // {
        //     Name "Meta"
        //     Tags{"LightMode" = "Meta"}

        //     Cull Off

        //     HLSLPROGRAM
        //     // Required to compile gles 2.0 with standard srp library
        //     #pragma prefer_hlslcc gles
        //     #pragma exclude_renderers d3d11_9x

        //     #pragma vertex UniversalVertexMeta
        //     #pragma fragment UniversalFragmentMeta

        //     #pragma shader_feature_local _SPECULAR_SETUP
        //     #pragma shader_feature_local _EMISSION
        //     #pragma shader_feature_local _METALLICSPECGLOSSMAP
        //     #pragma shader_feature_local _ALPHATEST_ON
        //     #pragma shader_feature_local _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

        //     #pragma shader_feature_local _SPECGLOSSMAP

        //     #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
        //     #include "Packages/com.unity.render-pipelines.universal/Shaders/LitMetaPass.hlsl"

        //     ENDHLSL
        // }

    }
    FallBack "Hidden/Universal Render Pipeline/FallbackError"
    CustomEditor "UnityEditor.Rendering.Universal.ShaderGUI.ClothShader"
}
