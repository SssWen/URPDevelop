using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEditor.Rendering.Universal.ShaderGUI
{
    [MovedFrom("UnityEditor.Rendering.LWRP.ShaderGUI")] public static class ClothGUI
    {
        public enum WorkflowMode
        {
            Specular = 0,
            Metallic
        }

        public enum SmoothnessMapChannel
        {
            SpecularMetallicAlpha,
            AlbedoAlpha,
        }

        public static class Styles
        {
            public static GUIContent workflowModeText = new GUIContent("Workflow Mode",
                "Select a workflow that fits your textures. Choose between Metallic or Specular.");

            public static GUIContent specularMapText =
                new GUIContent("Specular Map", "Sets and configures the map and color for the Specular workflow.");

            public static GUIContent metallicMapText =
                new GUIContent("Metallic Map", "Sets and configures the map for the Metallic workflow.");

            public static GUIContent smoothnessText = new GUIContent("Smoothness",
                "Controls the spread of highlights and reflections on the surface.");

            public static GUIContent smoothnessMapChannelText =
                new GUIContent("Source",
                    "Specifies where to sample a smoothness map from. By default, uses the alpha channel for your map.");

            public static GUIContent highlightsText = new GUIContent("Specular Highlights",
                "When enabled, the Material reflects the shine from direct lighting.");

            public static GUIContent reflectionsText =
                new GUIContent("Environment Reflections",
                    "When enabled, the Material samples reflections from the nearest Reflection Probes or Lighting Probe.");

            public static GUIContent occlusionText = new GUIContent("Occlusion Map",
                "Sets an occlusion map to simulate shadowing from ambient lighting.");

            public static readonly string[] metallicSmoothnessChannelNames = {"Metallic Alpha", "Albedo Alpha"};
            public static readonly string[] specularSmoothnessChannelNames = {"Specular Alpha", "Albedo Alpha"};

            #region Rim GUIContent
            public static GUIContent rimAlphaOn  = new GUIContent("边缘光透明控制", "");
            public static GUIContent rimAlphaMin  = new GUIContent("Edge透明区间Min(0)", "");
            public static GUIContent rimAlphaMax     = new GUIContent("Edge透明区间Max(1)", "");
            public static GUIContent rimAlphaEnhance     = new GUIContent("Edge强化透明强度(0)", "");
            public static GUIContent transparency     = new GUIContent("Clip透明强度(1)", "");
            public static GUIContent minTransparency     = new GUIContent("Clip最小透明值(0)", "");
            
            #endregion 
            
            #region Rim Light
            public static GUIContent rimLightOn  = new GUIContent("边缘光控制", "");
            public static GUIContent rimLightMin  = new GUIContent("RimLightMin", "");
            public static GUIContent rimLightMax     = new GUIContent("RimLightMax", "");                        
            public static GUIContent rimLightColor     = new GUIContent("RimLightColor", "");            
            #endregion 

            #region TCP Rim 
            public static GUIContent tcp_rim_on  = new GUIContent("TCP 边缘光控制", "");
            public static GUIContent tcp_rimColor  = new GUIContent("TCP RimLightColor", "");
            public static GUIContent tcp_rimStrength     = new GUIContent("TCP RimStrength", "");
            public static GUIContent tcp_rimMin     = new GUIContent("TCP RimMin", "");
            public static GUIContent tcp_rimMax     = new GUIContent("TCP RimMax", "");

            public static GUIContent tcp_rimOffset_on  = new GUIContent("TCP Offset On", "");
            public static GUIContent tcp_rimOffsetX  = new GUIContent("TCP Offset X", "");
            public static GUIContent tcp_rimOffsetY  = new GUIContent("TCP Offset Y", "");
            public static GUIContent tcp_rimOffsetZ  = new GUIContent("TCP Offset Z", "");
            #endregion 
            
            #region SharpeLightChange
            public static GUIContent sharpLightChangeOn  = new GUIContent("最后颜色控制", "");
            public static GUIContent highLightColor  = new GUIContent("强行修改亮部分", "");
            public static GUIContent shadowLightColor  = new GUIContent("强行修改暗部部分", "");
            #endregion 

            #region WrapLighting
            public static GUIContent wrapLightingOn  = new GUIContent("颜色散色", "");
            public static GUIContent threshold1  = new GUIContent("Threshold1", "");
            public static GUIContent threshold2  = new GUIContent("Threshold2", "");
            public static GUIContent attenuationControl  = new GUIContent("AttenControl[默认=1]", "");
            #endregion 

            #region Anistropic
            public static GUIContent anistropic  = new GUIContent("各向异性", "");
            public static GUIContent specularColor  = new GUIContent("SpecularColor", "");
            public static GUIContent roughnessX     = new GUIContent("RoughnessX", "");                        
            public static GUIContent roughnessY     = new GUIContent("RoughnessY", "");            
            public static GUIContent lightDirX     = new GUIContent("LightDirX", "");
            public static GUIContent lightDirY     = new GUIContent("LightDirY", "");
            public static GUIContent lightDirZ     = new GUIContent("LightDirZ", "");
            public static GUIContent anisNoiseTex  = new GUIContent("噪点图", "");
            public static GUIContent shiftX  = new GUIContent("ShiftX", "");
            public static GUIContent shiftY  = new GUIContent("ShiftY", "");
            public static GUIContent offset  = new GUIContent("Offset", "");
            public static GUIContent rotate  = new GUIContent("Rotate", "");
            
            #endregion 

            #region Layer GUIContent
            public static GUIContent layer0TexText = new GUIContent("Layer0", "");            
            public static GUIContent layer0ColorText = new GUIContent("Layer0Color", "");
            public static GUIContent layer0SmoothnessText = new GUIContent("Layer0Smoothness", "Layer0 Smoothness");
            public static GUIContent layer0MetallicText = new GUIContent("Layer0Metallic", "Layer0 Metallic");        
            public static GUIContent layer0UVSetText = new GUIContent("Layer0UVSet", "Layer0 UVSet");
            public static GUIContent layer0NormalText = new GUIContent("Layer0Normal", "Layer0 Normal Texture");
            public static GUIContent layer0NormalModeText = new GUIContent("NormalBlendMode", ""); 

            public static GUIContent layer1TexText = new GUIContent("Layer1[Clip]", "");            
            public static GUIContent layer1ColorText = new GUIContent("Layer1Color", "");
            public static GUIContent layer1SmoothnessText = new GUIContent("Layer1Smoothness", "");
            public static GUIContent layer1MetallicText = new GUIContent("Layer1Metallic", "");
            public static GUIContent layer1NormalModeText = new GUIContent("NormalBlendMode", "");
            public static GUIContent layer1UVSetText = new GUIContent("Layer1UVSet", "");
            public static GUIContent layer1NormalText = new GUIContent("Layer1Normal", "");
            public static GUIContent layer1CutoffText = new GUIContent("Alpha Cutoff", "");

            public static GUIContent layer2TexText = new GUIContent("Layer2", "");            
            public static GUIContent layer2ColorText = new GUIContent("Layer2Color", "");
            public static GUIContent layer2SmoothnessText = new GUIContent("Layer2Smoothness", "Layer2 Smoothness");
            public static GUIContent layer2MetallicText = new GUIContent("Layer2Metallic", "Layer2 Metallic");        
            public static GUIContent layer2UVSetText = new GUIContent("Layer2UVSet", "Layer2 UVSet");
            public static GUIContent layer2NormalText = new GUIContent("Layer2Normal", "Layer2 Normal Texture");
            public static GUIContent layer2NormalModeText = new GUIContent("NormalBlendMode", "");
                        
            public static GUIContent layer3TexText = new GUIContent("Layer3", "");            
            public static GUIContent layer3ColorText = new GUIContent("Layer3Color", "");
            public static GUIContent layer3SmoothnessText = new GUIContent("Layer3Smoothness", "");
            public static GUIContent layer3MetallicText = new GUIContent("Layer3Metallic", "");
            public static GUIContent layer3UVSetText = new GUIContent("Layer3UVSet", "");
            public static GUIContent layer3NormalText = new GUIContent("Layer3Normal", "");
            public static GUIContent layer3NormalModeText = new GUIContent("NormalBlendMode", "");
            

            public static GUIContent layer4TexText = new GUIContent("Layer4", "");            
            public static GUIContent layer4ColorText = new GUIContent("Layer4Color", "");
            public static GUIContent layer4SmoothnessText = new GUIContent("Layer4Smoothness", "");
            public static GUIContent layer4MetallicText = new GUIContent("Layer4Metallic", "");
            public static GUIContent layer4UVSetText = new GUIContent("Layer4UVSet", "");
            public static GUIContent layer4NormalText = new GUIContent("Layer4Normal", "");
            public static GUIContent layer4NormalModeText = new GUIContent("NormalBlendMode", "");
            

            public static GUIContent layer5TexText = new GUIContent("Layer5", "Layer5 Texture");            
            public static GUIContent layer5ColorText = new GUIContent("Layer5Color", "Layer5 Color");
            public static GUIContent layer5SmoothnessText = new GUIContent("Layer5Smoothness", "Layer5 Smoothness");
            public static GUIContent layer5MetallicText = new GUIContent("Layer5Metallic", "Layer5 Metallic");
            public static GUIContent layer5UVSetText = new GUIContent("Layer5UVSet", "Layer5 UVSet");
            public static GUIContent layer5NormalText = new GUIContent("Layer5Normal", "Layer5 Normal Texture");
            public static GUIContent layer5NormalModeText = new GUIContent("NormalBlendMode", "");
            

            public static GUIContent layer6TexText = new GUIContent("Layer6", "Layer6 Texture");            
            public static GUIContent layer6ColorText = new GUIContent("Layer6Color", "Layer6 Color");
            public static GUIContent layer6SmoothnessText = new GUIContent("Layer6Smoothness", "Layer6 Smoothness");
            public static GUIContent layer6MetallicText = new GUIContent("Layer6Metallic", "Layer6 Metallic");
            public static GUIContent layer6UVSetText = new GUIContent("Layer6UVSet", "Layer6 UVSet");
            public static GUIContent layer6NormalText = new GUIContent("Layer6Normal", "Layer6 Normal Texture");
            public static GUIContent layer6NormalModeText = new GUIContent("NormalBlendMode", "");
            
            
            public static GUIContent layer7TexText = new GUIContent("Layer7", "Layer7 Texture");            
            public static GUIContent layer7ColorText = new GUIContent("Layer7Color", "Layer7 Color");
            public static GUIContent layer7SmoothnessText = new GUIContent("Layer7Smoothness", "Layer7 Smoothness");
            public static GUIContent layer7MetallicText = new GUIContent("Layer7Metallic", "Layer7 Metallic");
            public static GUIContent layer7UVSetText = new GUIContent("Layer7UVSet", "Layer7 UVSet");
            public static GUIContent layer7NormalText = new GUIContent("Layer7Normal", "Layer7 Normal Texture");
            public static GUIContent layer7NormalModeText = new GUIContent("NormalBlendMode", "");
            #endregion

            #region Sparkle GUIContent
            public static GUIContent sparkleTex     = new GUIContent("闪点形状", "");
            public static GUIContent sparkleNoiseTex= new GUIContent("噪点图", "");
            public static GUIContent sparkleColor1  = new GUIContent("闪点颜色1", "");
            public static GUIContent sparkleColor2  = new GUIContent("闪点颜色2", "");
            public static GUIContent radiusRandom   = new GUIContent("radiusRandom", "");
            public static GUIContent offsetRandom   = new GUIContent("offsetRandom", "");
            public static GUIContent deleteSmall    = new GUIContent("deleteSmall", "");
            public static GUIContent deleteRandom   = new GUIContent("deleteRandom", "");
            public static GUIContent colorRandom    = new GUIContent("colorRandom", "");
            public static GUIContent flashSpeed     = new GUIContent("flashSpeed", "");
            public static GUIContent darkTime       = new GUIContent("darkTime", "");
            public static GUIContent flashZone      = new GUIContent("flashZone", "");
            public static GUIContent flashMin       = new GUIContent("flashMin", "");            
            public static GUIContent flashMetallic  = new GUIContent("flashMetallic", "");
            public static GUIContent flashSmoothness= new GUIContent("flashSmoothness", "");
            public static GUIContent randomSeed     = new GUIContent("randomSeed", "");
            #endregion
            #region Reflection GUIContent
            public static GUIContent reflectionTex  = new GUIContent("反射球", "");
            public static GUIContent brightness     = new GUIContent("高光强度", "");
            public static GUIContent yrotation     = new GUIContent("Y轴旋转", "");
            #endregion 
        }

        public struct LitProperties
        {
            // Surface Option Props
            public MaterialProperty workflowMode;

            // Surface Input Props
            public MaterialProperty metallic;
            public MaterialProperty specColor;
            public MaterialProperty metallicGlossMap;
            public MaterialProperty specGlossMap;
            public MaterialProperty smoothness;
            public MaterialProperty smoothnessMapChannel;
            public MaterialProperty bumpMapProp;
            public MaterialProperty bumpScaleProp;
            public MaterialProperty occlusionStrength;
            public MaterialProperty occlusionMap; 

            // Advanced Props
            public MaterialProperty highlights;
            public MaterialProperty reflections;

            #region AddLayer
            // Layer
            public MaterialProperty layer0Tex;            
            public MaterialProperty layer0Color;
            public MaterialProperty layer0Smoothness;
            public MaterialProperty layer0Metallic;
            public MaterialProperty layer0UVSet;
            public MaterialProperty layer0Normal;
            public MaterialProperty layer0NormalScale;
            public MaterialProperty layer0NormalMode;

            public MaterialProperty layer1Tex;            
            public MaterialProperty layer1Color;
            public MaterialProperty layer1Smoothness;
            public MaterialProperty layer1Metallic;
            public MaterialProperty layer1UVSet;
            public MaterialProperty layer1Normal;
            public MaterialProperty layer1NormalMode; //_Layer1NormalMode
            public MaterialProperty layer1NormalScale;
            public MaterialProperty layer1Cutoff;

            public MaterialProperty layer2Tex;            
            public MaterialProperty layer2Color;
            public MaterialProperty layer2Smoothness;
            public MaterialProperty layer2Metallic;
            public MaterialProperty layer2UVSet;
            public MaterialProperty layer2Normal;
            public MaterialProperty layer2NormalScale;
            public MaterialProperty layer2NormalMode;

            public MaterialProperty layer3Tex;            
            public MaterialProperty layer3Color;
            public MaterialProperty layer3Smoothness;
            public MaterialProperty layer3Metallic;
            public MaterialProperty layer3UVSet;
            public MaterialProperty layer3Normal;
            public MaterialProperty layer3NormalScale;
            public MaterialProperty layer3NormalMode;

            public MaterialProperty layer4Tex;            
            public MaterialProperty layer4Color;
            public MaterialProperty layer4Smoothness;
            public MaterialProperty layer4Metallic;
            public MaterialProperty layer4UVSet;
            public MaterialProperty layer4Normal;
            public MaterialProperty layer4NormalScale;
            public MaterialProperty layer4NormalMode;

            public MaterialProperty layer5Tex;            
            public MaterialProperty layer5Color;
            public MaterialProperty layer5Smoothness;
            public MaterialProperty layer5Metallic;
            public MaterialProperty layer5UVSet;
            public MaterialProperty layer5Normal;
            public MaterialProperty layer5NormalScale;
            public MaterialProperty layer5NormalMode;

            public MaterialProperty layer6Tex;            
            public MaterialProperty layer6Color;
            public MaterialProperty layer6Smoothness;
            public MaterialProperty layer6Metallic;
            public MaterialProperty layer6UVSet;
            public MaterialProperty layer6Normal;
            public MaterialProperty layer6NormalScale;
            public MaterialProperty layer6NormalMode;

            public MaterialProperty layer7Tex;            
            public MaterialProperty layer7Color;
            public MaterialProperty layer7Smoothness;
            public MaterialProperty layer7Metallic;
            public MaterialProperty layer7UVSet;
            public MaterialProperty layer7Normal;
            public MaterialProperty layer7NormalScale;
            public MaterialProperty layer7NormalMode;

            #endregion


            #region Add Sparkle 闪点

            public MaterialProperty sparkleColorTex;
            public MaterialProperty sparkleNoiseTex;
               
            public MaterialProperty sparkleColor1;
            public MaterialProperty sparkleColor2;            
            public MaterialProperty radiusRandom;
            public MaterialProperty offsetRandom;
            public MaterialProperty deleteSmall;
            public MaterialProperty deleteRandom;
            public MaterialProperty colorRandom;            
            public MaterialProperty flashSpeed;
            public MaterialProperty darkTime;
            public MaterialProperty flashZone;
            public MaterialProperty flashMin;
            // public MaterialProperty flashRotate;
            public MaterialProperty flashMetallic;
            public MaterialProperty flashSmoothness;
            public MaterialProperty randomSeed;
  
            #endregion

            #region Add Reflection             
            public MaterialProperty reflectionTex;
            public MaterialProperty brightness;
            public MaterialProperty yrotation;
            #endregion

            #region Add Velvet 天鹅绒

            #endregion

            #region Rim
            public MaterialProperty rimAlphaOn;
            public MaterialProperty rimAlphaMin;
            public MaterialProperty rimAlphaMax;
            public MaterialProperty rimAlphaEnhance;
            public MaterialProperty transparency;
            public MaterialProperty minTransparency;
            // light
            public MaterialProperty rimLightOn;
            public MaterialProperty rimLightMin;
            public MaterialProperty rimLightMax;
            public MaterialProperty rimLightColor;
            #endregion

            #region TCP_Rim
            public MaterialProperty tcp_rim_on;
            public MaterialProperty tcp_rimColor;
            public MaterialProperty tcp_rimStrength;
            public MaterialProperty tcp_rimMin;
            public MaterialProperty tcp_rimMax;

            public MaterialProperty tcp_rimOffset_on;
            public MaterialProperty tcp_rimOffsetX;
            public MaterialProperty tcp_rimOffsetY;
            public MaterialProperty tcp_rimOffsetZ;
            #endregion

            #region SharpChangeLight
            public MaterialProperty sharpLightChangeOn;
            public MaterialProperty highLightColor;
            public MaterialProperty shadowLightColor;
            #endregion
            
            #region WrapLighting
            public MaterialProperty wrapLightingOn;
            public MaterialProperty threshold1;
            public MaterialProperty threshold2;
            public MaterialProperty attenuationControl;
            #endregion

            #region Anistropic
            public MaterialProperty anistropic;
            public MaterialProperty specularColor;            
            public MaterialProperty roughnessX;
            public MaterialProperty roughnessY;
            public MaterialProperty lightDirX;
            public MaterialProperty lightDirY;
            public MaterialProperty lightDirZ;
            public MaterialProperty anisNoiseTex;
            public MaterialProperty shiftX;
            public MaterialProperty shiftY;
            public MaterialProperty offset;
            public MaterialProperty rotate;             
            #endregion

            public LitProperties(MaterialProperty[] properties)
            {
                // Surface Option Props
                workflowMode = Fun_BaseShaderGUI.FindProperty("_WorkflowMode", properties, false);
                // Surface Input Props
                metallic = Fun_BaseShaderGUI.FindProperty("_Metallic", properties);
                specColor = Fun_BaseShaderGUI.FindProperty("_SpecColor", properties, false);
                metallicGlossMap = Fun_BaseShaderGUI.FindProperty("_MetallicGlossMap", properties);
                specGlossMap = Fun_BaseShaderGUI.FindProperty("_SpecGlossMap", properties, false);
                smoothness = Fun_BaseShaderGUI.FindProperty("_Smoothness", properties, false);
                smoothnessMapChannel = Fun_BaseShaderGUI.FindProperty("_SmoothnessTextureChannel", properties, false);
                bumpMapProp = Fun_BaseShaderGUI.FindProperty("_BumpMap", properties, false);
                bumpScaleProp = Fun_BaseShaderGUI.FindProperty("_BumpScale", properties, false);
                occlusionStrength = Fun_BaseShaderGUI.FindProperty("_OcclusionStrength", properties, false);
                occlusionMap = Fun_BaseShaderGUI.FindProperty("_OcclusionMap", properties, false);
                // Advanced Props
                highlights = Fun_BaseShaderGUI.FindProperty("_SpecularHighlights", properties, false);
                reflections = Fun_BaseShaderGUI.FindProperty("_EnvironmentReflections", properties, false);

                #region Rim
                rimAlphaOn = Fun_BaseShaderGUI.FindProperty("_RimAlphaOn", properties, false);
                rimAlphaMin = Fun_BaseShaderGUI.FindProperty("_RimAlphaMin", properties, false);
                rimAlphaMax = Fun_BaseShaderGUI.FindProperty("_RimAlphaMax", properties, false);
                rimAlphaEnhance = Fun_BaseShaderGUI.FindProperty("_RimAlphaEnhance", properties, false);
                transparency = Fun_BaseShaderGUI.FindProperty("_Transparency", properties, false);
                minTransparency = Fun_BaseShaderGUI.FindProperty("_MinTransparency", properties, false);
                #endregion
                #region RimLight
                rimLightOn = Fun_BaseShaderGUI.FindProperty("_RimLightOn", properties, false);
                rimLightMin = Fun_BaseShaderGUI.FindProperty("_RimLightMin", properties, false);
                rimLightMax = Fun_BaseShaderGUI.FindProperty("_RimLightMax", properties, false);
                rimLightColor = Fun_BaseShaderGUI.FindProperty("_RimLightColor", properties, false);                
                #endregion
                
                #region TCPRimLight
                tcp_rim_on = Fun_BaseShaderGUI.FindProperty("_TCP_Rim_On", properties, false);
                tcp_rimColor = Fun_BaseShaderGUI.FindProperty("_TCP_RimColor", properties, false);
                tcp_rimStrength = Fun_BaseShaderGUI.FindProperty("_TCP_RimStrength", properties, false);
                tcp_rimMin = Fun_BaseShaderGUI.FindProperty("_TCP_RimMin", properties, false);
                tcp_rimMax = Fun_BaseShaderGUI.FindProperty("_TCP_RimMax", properties, false);
                
                tcp_rimOffset_on = Fun_BaseShaderGUI.FindProperty("_TCP_RimOffset_On", properties, false);
                tcp_rimOffsetX = Fun_BaseShaderGUI.FindProperty("_TCP_RimOffsetX", properties, false);
                tcp_rimOffsetY = Fun_BaseShaderGUI.FindProperty("_TCP_RimOffsetY", properties, false);
                tcp_rimOffsetZ = Fun_BaseShaderGUI.FindProperty("_TCP_RimOffsetZ", properties, false);
                #endregion

                #region SharpeChangeLight
                sharpLightChangeOn = Fun_BaseShaderGUI.FindProperty("_SharpLightChangeOn", properties, false);
                highLightColor = Fun_BaseShaderGUI.FindProperty("_HighLightColor", properties, false);
                shadowLightColor = Fun_BaseShaderGUI.FindProperty("_ShadowLightColor", properties, false);
                
                #endregion
                #region WrapLighting
                wrapLightingOn = Fun_BaseShaderGUI.FindProperty("_WrapLightingOn", properties, false);
                threshold1 = Fun_BaseShaderGUI.FindProperty("_Threshold1", properties, false);
                threshold2 = Fun_BaseShaderGUI.FindProperty("_Threshold2", properties, false);
                attenuationControl = Fun_BaseShaderGUI.FindProperty("_AttenuationControl", properties, false);
                #endregion
                

                #region Anistropic
                anistropic = Fun_BaseShaderGUI.FindProperty("_AnistropicOn", properties, false);
                specularColor = Fun_BaseShaderGUI.FindProperty("_SpecularColor", properties, false);
                roughnessX = Fun_BaseShaderGUI.FindProperty("_RoughnessX", properties, false);
                roughnessY = Fun_BaseShaderGUI.FindProperty("_RoughnessY", properties, false);                
                lightDirX = Fun_BaseShaderGUI.FindProperty("_LightDirX", properties, false);
                lightDirY = Fun_BaseShaderGUI.FindProperty("_LightDirY", properties, false);
                lightDirZ = Fun_BaseShaderGUI.FindProperty("_LightDirZ", properties, false);                
                anisNoiseTex = Fun_BaseShaderGUI.FindProperty("_AnisNoiseTex", properties, false);                
                shiftX = Fun_BaseShaderGUI.FindProperty("_ShiftX", properties, false);                
                shiftY = Fun_BaseShaderGUI.FindProperty("_ShiftY", properties, false);                
                offset = Fun_BaseShaderGUI.FindProperty("_Offset", properties, false);                
                rotate = Fun_BaseShaderGUI.FindProperty("_Rotate", properties, false);                
                #endregion

                // Cloth Layer 
                #region Cloth Layer
                layer0Tex = Fun_BaseShaderGUI.FindProperty("_Layer0Tex", properties, false);                
                layer0UVSet = Fun_BaseShaderGUI.FindProperty("_Layer0UVSet", properties, false);
                layer0Normal = Fun_BaseShaderGUI.FindProperty("_Layer0Normal", properties, false);
                layer0NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer0NormalScale", properties, false);
                layer0Color = Fun_BaseShaderGUI.FindProperty("_Layer0Color", properties, false);
                layer0Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer0Smoothness", properties, false);
                layer0Metallic = Fun_BaseShaderGUI.FindProperty("_Layer0Metallic", properties, false);
                layer0NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer0NormalMode", properties, false);


                layer1Tex = Fun_BaseShaderGUI.FindProperty("_Layer1Tex", properties, false);                
                layer1UVSet = Fun_BaseShaderGUI.FindProperty("_Layer1UVSet", properties, false);
                layer1Normal = Fun_BaseShaderGUI.FindProperty("_Layer1Normal", properties, false);
                layer1NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer1NormalScale", properties, false);
                layer1NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer1NormalMode", properties, false);
                layer1Color = Fun_BaseShaderGUI.FindProperty("_Layer1Color", properties, false);
                layer1Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer1Smoothness", properties, false);
                layer1Metallic = Fun_BaseShaderGUI.FindProperty("_Layer1Metallic", properties, false);
                layer1Cutoff = Fun_BaseShaderGUI.FindProperty("_Layer1Cutoff", properties, false);

                layer2Tex = Fun_BaseShaderGUI.FindProperty("_Layer2Tex", properties, false);                
                layer2UVSet = Fun_BaseShaderGUI.FindProperty("_Layer2UVSet", properties, false);
                layer2Normal = Fun_BaseShaderGUI.FindProperty("_Layer2Normal", properties, false);
                layer2NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer2NormalScale", properties, false);
                layer2Color = Fun_BaseShaderGUI.FindProperty("_Layer2Color", properties, false);
                layer2Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer2Smoothness", properties, false);
                layer2Metallic = Fun_BaseShaderGUI.FindProperty("_Layer2Metallic", properties, false);
                layer2NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer2NormalMode", properties, false);

                layer3Tex = Fun_BaseShaderGUI.FindProperty("_Layer3Tex", properties, false);                
                layer3UVSet = Fun_BaseShaderGUI.FindProperty("_Layer3UVSet", properties, false);
                layer3Normal = Fun_BaseShaderGUI.FindProperty("_Layer3Normal", properties, false);
                layer3NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer3NormalScale", properties, false);
                layer3Color = Fun_BaseShaderGUI.FindProperty("_Layer3Color", properties, false);
                layer3Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer3Smoothness", properties, false);
                layer3Metallic = Fun_BaseShaderGUI.FindProperty("_Layer3Metallic", properties, false);
                layer3NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer3NormalMode", properties, false);

                layer4Tex = Fun_BaseShaderGUI.FindProperty("_Layer4Tex", properties, false);                
                layer4UVSet = Fun_BaseShaderGUI.FindProperty("_Layer4UVSet", properties, false);
                layer4Normal = Fun_BaseShaderGUI.FindProperty("_Layer4Normal", properties, false);
                layer4NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer4NormalScale", properties, false);
                layer4Color = Fun_BaseShaderGUI.FindProperty("_Layer4Color", properties, false);
                layer4Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer4Smoothness", properties, false);
                layer4Metallic = Fun_BaseShaderGUI.FindProperty("_Layer4Metallic", properties, false);
                layer4NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer4NormalMode", properties, false);


                layer5Tex = Fun_BaseShaderGUI.FindProperty("_Layer5Tex", properties, false);                
                layer5UVSet = Fun_BaseShaderGUI.FindProperty("_Layer5UVSet", properties, false);
                layer5Normal = Fun_BaseShaderGUI.FindProperty("_Layer5Normal", properties, false);
                layer5NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer5NormalScale", properties, false);
                layer5Color = Fun_BaseShaderGUI.FindProperty("_Layer5Color", properties, false);
                layer5Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer5Smoothness", properties, false);
                layer5Metallic = Fun_BaseShaderGUI.FindProperty("_Layer5Metallic", properties, false);
                layer5NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer5NormalMode", properties, false);


                layer6Tex = Fun_BaseShaderGUI.FindProperty("_Layer6Tex", properties, false);                
                layer6UVSet = Fun_BaseShaderGUI.FindProperty("_Layer6UVSet", properties, false);
                layer6Normal = Fun_BaseShaderGUI.FindProperty("_Layer6Normal", properties, false);
                layer6NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer6NormalScale", properties, false);
                layer6Color = Fun_BaseShaderGUI.FindProperty("_Layer6Color", properties, false);
                layer6Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer6Smoothness", properties, false);
                layer6Metallic = Fun_BaseShaderGUI.FindProperty("_Layer6Metallic", properties, false);
                layer6NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer6NormalMode", properties, false);

                layer7Tex = Fun_BaseShaderGUI.FindProperty("_Layer7Tex", properties, false);                
                layer7UVSet = Fun_BaseShaderGUI.FindProperty("_Layer7UVSet", properties, false);
                layer7Normal = Fun_BaseShaderGUI.FindProperty("_Layer7Normal", properties, false);
                layer7NormalScale = Fun_BaseShaderGUI.FindProperty("_Layer7NormalScale", properties, false);
                layer7Color = Fun_BaseShaderGUI.FindProperty("_Layer7Color", properties, false);
                layer7Smoothness = Fun_BaseShaderGUI.FindProperty("_Layer7Smoothness", properties, false);
                layer7Metallic = Fun_BaseShaderGUI.FindProperty("_Layer7Metallic", properties, false);
                layer7NormalMode = Fun_BaseShaderGUI.FindProperty("_Layer7NormalMode", properties, false);
                #endregion

                // Sparkle 
                #region Sparkle

                sparkleColorTex = Fun_BaseShaderGUI.FindProperty("_FlashTex", properties, false);
                sparkleNoiseTex = Fun_BaseShaderGUI.FindProperty("_SparkleNoiseTex", properties, false);
                sparkleColor1   = Fun_BaseShaderGUI.FindProperty("_FlashColor1", properties, false);
                sparkleColor2   = Fun_BaseShaderGUI.FindProperty("_FlashColor2", properties, false);
                radiusRandom    = Fun_BaseShaderGUI.FindProperty("_RadiusRandom", properties, false);                
                deleteSmall     = Fun_BaseShaderGUI.FindProperty("_DeleteSmall", properties, false);
                deleteRandom    = Fun_BaseShaderGUI.FindProperty("_DeleteRandom", properties, false);
                colorRandom     = Fun_BaseShaderGUI.FindProperty("_ColorRandom", properties, false);
                offsetRandom    = Fun_BaseShaderGUI.FindProperty("_OffsetRandom", properties, false);
                flashSpeed      = Fun_BaseShaderGUI.FindProperty("_FlashSpeed", properties, false);
                darkTime        = Fun_BaseShaderGUI.FindProperty("_DarkTime", properties, false);
                flashZone       = Fun_BaseShaderGUI.FindProperty("_FlashZone", properties, false);
                flashMin        = Fun_BaseShaderGUI.FindProperty("_FlashMin", properties, false);                
                flashMetallic   = Fun_BaseShaderGUI.FindProperty("_FlashMetallic", properties, false);
                flashSmoothness = Fun_BaseShaderGUI.FindProperty("_FlashSmoothness", properties, false);
                randomSeed      = Fun_BaseShaderGUI.FindProperty("_RandomSeed", properties, false);
                #endregion

                #region Reflection                
                reflectionTex   = Fun_BaseShaderGUI.FindProperty("_ReflectionTex", properties, false);
                brightness   = Fun_BaseShaderGUI.FindProperty("_Brightness", properties, false);
                yrotation   = Fun_BaseShaderGUI.FindProperty("_YRotation", properties, false);
                #endregion
            }
        }

        public static void Inputs(LitProperties properties, MaterialEditor materialEditor, Material material)
        {
            DoMetallicSpecularArea(properties, materialEditor, material);
            Fun_BaseShaderGUI.DrawNormalArea(materialEditor, properties.bumpMapProp, properties.bumpScaleProp);

            if (properties.occlusionMap != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.occlusionText, properties.occlusionMap,
                    properties.occlusionMap.textureValue != null ? properties.occlusionStrength : null);
            }      
        }

        public static void DoMetallicSpecularArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {
            string[] smoothnessChannelNames;
            bool hasGlossMap = false;
            if (properties.workflowMode == null ||
                (WorkflowMode) properties.workflowMode.floatValue == WorkflowMode.Metallic)
            {
                hasGlossMap = properties.metallicGlossMap.textureValue != null;
                smoothnessChannelNames = Styles.metallicSmoothnessChannelNames;
                materialEditor.TexturePropertySingleLine(Styles.metallicMapText, properties.metallicGlossMap,
                    hasGlossMap ? null : properties.metallic);
            }
            else
            {
                hasGlossMap = properties.specGlossMap.textureValue != null;
                smoothnessChannelNames = Styles.specularSmoothnessChannelNames;
                Fun_BaseShaderGUI.TextureColorProps(materialEditor, Styles.specularMapText, properties.specGlossMap,
                    hasGlossMap ? null : properties.specColor);
            }
            EditorGUI.indentLevel++;
            DoSmoothness(properties, material, smoothnessChannelNames);
            EditorGUI.indentLevel--;
        }

        public static void DoSmoothness(LitProperties properties, Material material, string[] smoothnessChannelNames)
        {
            var opaque = ((Fun_BaseShaderGUI.SurfaceType) material.GetFloat("_Surface") ==
                          Fun_BaseShaderGUI.SurfaceType.Opaque);
            EditorGUI.indentLevel++;
            EditorGUI.BeginChangeCheck();
            EditorGUI.showMixedValue = properties.smoothness.hasMixedValue;
            var smoothness = EditorGUILayout.Slider(Styles.smoothnessText, properties.smoothness.floatValue, 0f, 1f);
            if (EditorGUI.EndChangeCheck())
                properties.smoothness.floatValue = smoothness;
            EditorGUI.showMixedValue = false;

            if (properties.smoothnessMapChannel != null) // smoothness channel
            {
                EditorGUI.indentLevel++;
                EditorGUI.BeginDisabledGroup(!opaque);
                EditorGUI.BeginChangeCheck();
                EditorGUI.showMixedValue = properties.smoothnessMapChannel.hasMixedValue;
                var smoothnessSource = (int) properties.smoothnessMapChannel.floatValue;
                if (opaque)
                    smoothnessSource = EditorGUILayout.Popup(Styles.smoothnessMapChannelText, smoothnessSource,
                        smoothnessChannelNames);
                else
                    EditorGUILayout.Popup(Styles.smoothnessMapChannelText, 0, smoothnessChannelNames);
                if (EditorGUI.EndChangeCheck())
                    properties.smoothnessMapChannel.floatValue = smoothnessSource;
                EditorGUI.showMixedValue = false;
                EditorGUI.EndDisabledGroup();
                EditorGUI.indentLevel--;
            }
            EditorGUI.indentLevel--;
        }

        public static SmoothnessMapChannel GetSmoothnessMapChannel(Material material)
        {
            int ch = (int) material.GetFloat("_SmoothnessTextureChannel");
            if (ch == (int) SmoothnessMapChannel.AlbedoAlpha)
                return SmoothnessMapChannel.AlbedoAlpha;

            return SmoothnessMapChannel.SpecularMetallicAlpha;
        }

        public static void SetMaterialKeywords(Material material)
        {
            // Note: keywords must be based on Material value not on MaterialProperty due to multi-edit & material animation
            // (MaterialProperty value might come from renderer material property block)
            var hasGlossMap = false;
            var isSpecularWorkFlow = false;
            var opaque = ((Fun_BaseShaderGUI.SurfaceType) material.GetFloat("_Surface") ==
                          Fun_BaseShaderGUI.SurfaceType.Opaque);
            if (material.HasProperty("_WorkflowMode"))
            {
                isSpecularWorkFlow = (WorkflowMode) material.GetFloat("_WorkflowMode") == WorkflowMode.Specular;
                if (isSpecularWorkFlow)
                    hasGlossMap = material.GetTexture("_SpecGlossMap") != null;
                else
                    hasGlossMap = material.GetTexture("_MetallicGlossMap") != null;
            }
            else
            {
                hasGlossMap = material.GetTexture("_MetallicGlossMap") != null;
            }

            CoreUtils.SetKeyword(material, "_SPECULAR_SETUP", isSpecularWorkFlow);

            CoreUtils.SetKeyword(material, "_METALLICSPECGLOSSMAP", hasGlossMap);

            if (material.HasProperty("_SpecularHighlights"))
                CoreUtils.SetKeyword(material, "_SPECULARHIGHLIGHTS_OFF",
                    material.GetFloat("_SpecularHighlights") == 0.0f);
            if (material.HasProperty("_EnvironmentReflections"))
                CoreUtils.SetKeyword(material, "_ENVIRONMENTREFLECTIONS_OFF",
                    material.GetFloat("_EnvironmentReflections") == 0.0f);
            if (material.HasProperty("_OcclusionMap"))
                CoreUtils.SetKeyword(material, "_OCCLUSIONMAP", material.GetTexture("_OcclusionMap"));

            if (material.HasProperty("_SmoothnessTextureChannel"))
            {
                CoreUtils.SetKeyword(material, "_SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A",
                    GetSmoothnessMapChannel(material) == SmoothnessMapChannel.AlbedoAlpha && opaque);
            }            
            SetClothMaterialKeywords(material);
        }

        // Cloth Keywords
        public static void SetClothMaterialKeywords(Material material)
        {
            if (material.HasProperty("_Layer0Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_0_TEX", material.GetTexture("_Layer0Tex"));
            if (material.HasProperty("_Layer1Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_0_NORMAL", material.GetTexture("_Layer0Normal"));            

            if (material.HasProperty("_Layer1Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_1_TEX", material.GetTexture("_Layer1Tex"));
            if (material.HasProperty("_Layer1Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_1_NORMAL", material.GetTexture("_Layer1Normal"));
            

            if (material.HasProperty("_Layer2Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_2_TEX", material.GetTexture("_Layer2Tex"));
            if (material.HasProperty("_Layer2Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_2_NORMAL", material.GetTexture("_Layer2Normal"));
            

            if (material.HasProperty("_Layer3Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_3_TEX", material.GetTexture("_Layer3Tex"));
            if (material.HasProperty("_Layer3Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_3_NORMAL", material.GetTexture("_Layer3Normal"));
            

            if (material.HasProperty("_Layer4Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_4_TEX", material.GetTexture("_Layer4Tex"));
            if (material.HasProperty("_Layer4Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_4_NORMAL", material.GetTexture("_Layer4Normal"));
            

            if (material.HasProperty("_Layer5Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_5_TEX", material.GetTexture("_Layer5Tex"));
            if (material.HasProperty("_Layer5Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_5_NORMAL", material.GetTexture("_Layer5Normal"));
            

            if (material.HasProperty("_Layer6Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_6_TEX", material.GetTexture("_Layer6Tex"));
            if (material.HasProperty("_Layer6Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_6_NORMAL", material.GetTexture("_Layer6Normal"));


            if (material.HasProperty("_Layer7Tex"))
            CoreUtils.SetKeyword(material, "_LAYER_7_TEX", material.GetTexture("_Layer7Tex"));
            if (material.HasProperty("_Layer7Normal"))
            CoreUtils.SetKeyword(material, "_LAYER_7_NORMAL", material.GetTexture("_Layer7Normal"));

            

            // key for layer uv set
            CoreUtils.SetKeyword(material, "_Layer0UVSet_0", material.GetFloat("_Layer0UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer0UVSet_1", material.GetFloat("_Layer0UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer0UVSet_2", material.GetFloat("_Layer0UVSet") == 2);
            CoreUtils.SetKeyword(material, "_Layer0UVSet_3", material.GetFloat("_Layer0UVSet") == 3);

            CoreUtils.SetKeyword(material, "_Layer1UVSet_0", material.GetFloat("_Layer1UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer1UVSet_1", material.GetFloat("_Layer1UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer1UVSet_2", material.GetFloat("_Layer1UVSet") == 2);            
            CoreUtils.SetKeyword(material, "_Layer1UVSet_3", material.GetFloat("_Layer1UVSet") == 3);            

            CoreUtils.SetKeyword(material, "_Layer2UVSet_0", material.GetFloat("_Layer2UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer2UVSet_1", material.GetFloat("_Layer2UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer2UVSet_2", material.GetFloat("_Layer2UVSet") == 2);            
            CoreUtils.SetKeyword(material, "_Layer2UVSet_3", material.GetFloat("_Layer2UVSet") == 3);            

            CoreUtils.SetKeyword(material, "_Layer3UVSet_0", material.GetFloat("_Layer3UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer3UVSet_1", material.GetFloat("_Layer3UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer3UVSet_2", material.GetFloat("_Layer3UVSet") == 2);            
            CoreUtils.SetKeyword(material, "_Layer3UVSet_3", material.GetFloat("_Layer3UVSet") == 3);            

            CoreUtils.SetKeyword(material, "_Layer4UVSet_0", material.GetFloat("_Layer4UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer4UVSet_1", material.GetFloat("_Layer4UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer4UVSet_2", material.GetFloat("_Layer4UVSet") == 2);            
            CoreUtils.SetKeyword(material, "_Layer4UVSet_3", material.GetFloat("_Layer4UVSet") == 3);            

            CoreUtils.SetKeyword(material, "_Layer5UVSet_0", material.GetFloat("_Layer5UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer5UVSet_1", material.GetFloat("_Layer5UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer5UVSet_2", material.GetFloat("_Layer5UVSet") == 2);            
            CoreUtils.SetKeyword(material, "_Layer5UVSet_3", material.GetFloat("_Layer5UVSet") == 3);            

            CoreUtils.SetKeyword(material, "_Layer6UVSet_0", material.GetFloat("_Layer6UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer6UVSet_1", material.GetFloat("_Layer6UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer6UVSet_2", material.GetFloat("_Layer6UVSet") == 2);            
            CoreUtils.SetKeyword(material, "_Layer6UVSet_3", material.GetFloat("_Layer6UVSet") == 3);            

            CoreUtils.SetKeyword(material, "_Layer7UVSet_0", material.GetFloat("_Layer7UVSet") == 0);
            CoreUtils.SetKeyword(material, "_Layer7UVSet_1", material.GetFloat("_Layer7UVSet") == 1);
            CoreUtils.SetKeyword(material, "_Layer7UVSet_2", material.GetFloat("_Layer7UVSet") == 2);            
            CoreUtils.SetKeyword(material, "_Layer7UVSet_3", material.GetFloat("_Layer7UVSet") == 3);            



            // Normal Blend Mode
            CoreUtils.SetKeyword(material, "_Layer0NormalMode_0", material.GetFloat("_Layer0NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer0NormalMode_1", material.GetFloat("_Layer0NormalMode") == 1);

            CoreUtils.SetKeyword(material, "_Layer1NormalMode_0", material.GetFloat("_Layer1NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer1NormalMode_1", material.GetFloat("_Layer1NormalMode") == 1);

            CoreUtils.SetKeyword(material, "_Layer2NormalMode_0", material.GetFloat("_Layer2NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer2NormalMode_1", material.GetFloat("_Layer2NormalMode") == 1);

            CoreUtils.SetKeyword(material, "_Layer3NormalMode_0", material.GetFloat("_Layer3NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer3NormalMode_1", material.GetFloat("_Layer3NormalMode") == 1);

            CoreUtils.SetKeyword(material, "_Layer4NormalMode_0", material.GetFloat("_Layer4NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer4NormalMode_1", material.GetFloat("_Layer4NormalMode") == 1);

            CoreUtils.SetKeyword(material, "_Layer5NormalMode_0", material.GetFloat("_Layer5NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer5NormalMode_1", material.GetFloat("_Layer5NormalMode") == 1);

            CoreUtils.SetKeyword(material, "_Layer6NormalMode_0", material.GetFloat("_Layer6NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer6NormalMode_1", material.GetFloat("_Layer6NormalMode") == 1);

            CoreUtils.SetKeyword(material, "_Layer7NormalMode_0", material.GetFloat("_Layer7NormalMode") == 0);
            CoreUtils.SetKeyword(material, "_Layer7NormalMode_1", material.GetFloat("_Layer7NormalMode") == 1);            

            // complex function
            if (material.HasProperty("_SparkleNoiseTex"))
                CoreUtils.SetKeyword(material, "_SPARKLE_ON", material.GetTexture("_SparkleNoiseTex"));
                
            if (material.HasProperty("_ReflectionTex"))            
                CoreUtils.SetKeyword(material, "_REFLECTION_ON", material.GetTexture("_ReflectionTex"));                            
            


            // Rim
            CoreUtils.SetKeyword(material, "_RIM_LIGHT_ON",material.GetInt("_RimLightOn") == 1);                            
            CoreUtils.SetKeyword(material, "_RIM_ALPHA_ON",material.GetInt("_RimAlphaOn") == 1);                            
            // Anistropic             
            CoreUtils.SetKeyword(material, "_ANISTROPIC_ON",material.GetInt("_AnistropicOn") == 1);                     
            if (material.HasProperty("_AnisNoiseTex"))
                CoreUtils.SetKeyword(material, "_ANIS_NOISE_TEX", material.GetTexture("_AnisNoiseTex"));       

            CoreUtils.SetKeyword(material, "_SHARPCHANGE_ON",material.GetInt("_SharpLightChangeOn") == 1);
            CoreUtils.SetKeyword(material, "_WRAPLIGHTING_ON",material.GetInt("_WrapLightingOn") == 1);

            CoreUtils.SetKeyword(material, "_TCP_RIM_ON",material.GetInt("_TCP_Rim_On") == 1);
            CoreUtils.SetKeyword(material, "_TCP_RIMOFFSET_ON",material.GetInt("_TCP_RimOffset_On") == 1);
        }
            
        public static void DoSparkleArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {
            if (properties.sparkleNoiseTex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.sparkleNoiseTex, properties.sparkleNoiseTex);
                if (material.GetTexture("_SparkleNoiseTex"))
                {
                    TextureLayout(materialEditor, Styles.sparkleTex, properties.sparkleColorTex);
                    materialEditor.TextureScaleOffsetProperty(properties.sparkleColorTex);
                    materialEditor.ShaderProperty(properties.sparkleColor1, Styles.sparkleColor1.text, 2);
                    materialEditor.ShaderProperty(properties.sparkleColor2, Styles.sparkleColor2.text, 2);
                    materialEditor.ShaderProperty(properties.radiusRandom,    Styles.radiusRandom.text, 2);
                    materialEditor.ShaderProperty(properties.offsetRandom,    Styles.offsetRandom.text, 2);
                    materialEditor.ShaderProperty(properties.deleteSmall    , Styles.deleteSmall.text, 2);
                    materialEditor.ShaderProperty(properties.deleteRandom   , Styles.deleteRandom.text, 2);                    
                    materialEditor.ShaderProperty(properties.colorRandom    , Styles.colorRandom.text, 2);
                    materialEditor.ShaderProperty(properties.flashZone      , Styles.flashZone.text, 2);
                    materialEditor.ShaderProperty(properties.flashMin       , Styles.flashMin.text, 2);
                    materialEditor.ShaderProperty(properties.flashSpeed     , Styles.flashSpeed.text, 2);
                    materialEditor.ShaderProperty(properties.darkTime       , Styles.darkTime.text, 2);
                    materialEditor.ShaderProperty(properties.flashMetallic  , Styles.flashMetallic.text, 2);
                    materialEditor.ShaderProperty(properties.flashSmoothness, Styles.flashSmoothness.text, 2);
                    materialEditor.ShaderProperty(properties.randomSeed     , Styles.randomSeed.text, 2);

                    // materialEditor.ShaderProperty(properties.flashRotate    , Styles.flashRotate.text, 2);                                        
                }
                else
                {
                    material.SetTexture("_SparkleNoiseTex", null);
                }                                
            }   
            if(properties.reflectionTex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.reflectionTex, properties.reflectionTex);
                materialEditor.ShaderProperty(properties.brightness       , Styles.brightness.text, 2);
                materialEditor.ShaderProperty(properties.yrotation       , Styles.yrotation.text, 2);
                // if (!material.GetTexture("_ReflectionTex"))
                //     material.SetTexture("_ReflectionTex", null);                
            }
            
        }
        public static void DoLayerArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {
            if (properties.layer0Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer0TexText, properties.layer0Tex);
                TextureLayout0(materialEditor, Styles.layer0NormalText, properties.layer0Normal, properties.layer0NormalScale);
                if (material.GetTexture("_Layer0Tex") || material.GetTexture("_Layer0Normal"))
                {         
                    if (material.GetTexture("_Layer0Tex"))
                    {                                                                                                
                        materialEditor.TextureScaleOffsetProperty(properties.layer0Tex);
                        materialEditor.ShaderProperty(properties.layer0Color, Styles.layer0ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer0Normal);                                                                                               
                    materialEditor.ShaderProperty(properties.layer0Smoothness, Styles.layer0SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer0Metallic, Styles.layer0MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer0UVSet, Styles.layer0UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer0NormalMode, Styles.layer0NormalModeText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer0Normal", null);                    
                }
            }

            if (properties.layer1Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer1TexText, properties.layer1Tex);
                TextureLayout0(materialEditor, Styles.layer1NormalText, properties.layer1Normal, properties.layer1NormalScale);
                if (material.GetTexture("_Layer1Tex") || material.GetTexture("_Layer1Normal"))
                {                                        
                    if (material.GetTexture("_Layer1Tex"))
                    {                                                
                        materialEditor.TextureScaleOffsetProperty(properties.layer1Tex);
                        materialEditor.ShaderProperty(properties.layer1Color, Styles.layer1ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer1Normal);
                    
                    materialEditor.ShaderProperty(properties.layer1Smoothness, Styles.layer1SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer1Metallic, Styles.layer1MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer1UVSet, Styles.layer1UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer1NormalMode, Styles.layer1NormalModeText.text, 2);
                    materialEditor.ShaderProperty(properties.layer1Cutoff, Styles.layer1CutoffText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer1Normal", null);                    
                }
            }

            if (properties.layer2Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer2TexText, properties.layer2Tex);
                TextureLayout0(materialEditor, Styles.layer2NormalText, properties.layer2Normal, properties.layer2NormalScale);
                if (material.GetTexture("_Layer2Tex") || material.GetTexture("_Layer2Normal"))
                {         
                    if (material.GetTexture("_Layer2Tex"))
                    {                                                                                                
                        materialEditor.TextureScaleOffsetProperty(properties.layer2Tex);
                        materialEditor.ShaderProperty(properties.layer2Color, Styles.layer2ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer2Normal);                                                                           
                    
                    materialEditor.ShaderProperty(properties.layer2Smoothness, Styles.layer2SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer2Metallic, Styles.layer2MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer2UVSet, Styles.layer2UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer2NormalMode, Styles.layer2NormalModeText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer2Normal", null);                    
                }
            }
            if (properties.layer3Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer3TexText, properties.layer3Tex);
                TextureLayout0(materialEditor, Styles.layer3NormalText, properties.layer3Normal, properties.layer3NormalScale);
                if (material.GetTexture("_Layer3Tex") || material.GetTexture("_Layer3Normal"))
                {         
                    if (material.GetTexture("_Layer3Tex"))
                    {                                                                        
                        materialEditor.TextureScaleOffsetProperty(properties.layer3Tex);
                        materialEditor.ShaderProperty(properties.layer3Color, Styles.layer3ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer3Normal);                                                                           
                    
                    materialEditor.ShaderProperty(properties.layer3Smoothness, Styles.layer3SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer3Metallic, Styles.layer3MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer3UVSet, Styles.layer3UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer3NormalMode, Styles.layer3NormalModeText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer3Normal", null);                    
                }
            }
    
          

            if (properties.layer4Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer4TexText, properties.layer4Tex);
                TextureLayout0(materialEditor, Styles.layer4NormalText, properties.layer4Normal, properties.layer4NormalScale);
                if (material.GetTexture("_Layer4Tex") || material.GetTexture("_Layer4Normal"))
                {         
                    if (material.GetTexture("_Layer4Tex"))
                    {                                                                        
                        materialEditor.TextureScaleOffsetProperty(properties.layer4Tex);
                        materialEditor.ShaderProperty(properties.layer4Color, Styles.layer4ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer4Normal);                                                                           
                    
                    materialEditor.ShaderProperty(properties.layer4Smoothness, Styles.layer4SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer4Metallic, Styles.layer4MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer4UVSet, Styles.layer4UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer4NormalMode, Styles.layer4NormalModeText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer4Normal", null);                    
                }
            }


            if (properties.layer5Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer5TexText, properties.layer5Tex);
                TextureLayout0(materialEditor, Styles.layer5NormalText, properties.layer5Normal, properties.layer5NormalScale);
                if (material.GetTexture("_Layer5Tex") || material.GetTexture("_Layer5Normal"))
                {         
                    if (material.GetTexture("_Layer5Tex"))
                    {                                                                        
                        materialEditor.TextureScaleOffsetProperty(properties.layer5Tex);
                        materialEditor.ShaderProperty(properties.layer5Color, Styles.layer5ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer5Normal);                                                                           
                    
                    materialEditor.ShaderProperty(properties.layer5Smoothness, Styles.layer5SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer5Metallic, Styles.layer5MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer5UVSet, Styles.layer5UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer5NormalMode, Styles.layer5NormalModeText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer5Normal", null);                    
                }
            }

            if (properties.layer6Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer6TexText, properties.layer6Tex);
                TextureLayout0(materialEditor, Styles.layer6NormalText, properties.layer6Normal, properties.layer6NormalScale);
                if (material.GetTexture("_Layer6Tex") || material.GetTexture("_Layer6Normal"))
                {         
                    if (material.GetTexture("_Layer6Tex"))
                    {                                                                        
                        materialEditor.TextureScaleOffsetProperty(properties.layer6Tex);
                        materialEditor.ShaderProperty(properties.layer6Color, Styles.layer6ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer6Normal);                                                                           
                    
                    materialEditor.ShaderProperty(properties.layer6Smoothness, Styles.layer6SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer6Metallic, Styles.layer6MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer6UVSet, Styles.layer6UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer6NormalMode, Styles.layer6NormalModeText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer6Normal", null);                    
                }
            }


             if (properties.layer7Tex != null)
            {
                materialEditor.TexturePropertySingleLine(Styles.layer7TexText, properties.layer7Tex);
                TextureLayout0(materialEditor, Styles.layer7NormalText, properties.layer7Normal, properties.layer7NormalScale);
                if (material.GetTexture("_Layer7Tex") || material.GetTexture("_Layer7Normal"))
                {         
                    if (material.GetTexture("_Layer7Tex"))
                    {                                                                        
                        materialEditor.TextureScaleOffsetProperty(properties.layer7Tex);
                        materialEditor.ShaderProperty(properties.layer7Color, Styles.layer7ColorText.text, 2);
                    }
                    else
                        materialEditor.TextureScaleOffsetProperty(properties.layer7Normal);                                                                           
                    
                    materialEditor.ShaderProperty(properties.layer7Smoothness, Styles.layer7SmoothnessText.text, 2);
                    materialEditor.ShaderProperty(properties.layer7Metallic, Styles.layer7MetallicText.text, 2);
                    materialEditor.ShaderProperty(properties.layer7UVSet, Styles.layer7UVSetText.text, 2);
                    materialEditor.ShaderProperty(properties.layer7NormalMode, Styles.layer7NormalModeText.text, 2);
                }
                else
                {
                    material.SetTexture("_Layer7Normal", null);                    
                }
            }
            
        }

        public static void DoRimArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {                        
            materialEditor.ShaderProperty(properties.rimAlphaOn, Styles.rimAlphaOn.text);
            var rimAlphaOn = (material.GetInt("_RimAlphaOn") == 0);

            EditorGUI.BeginDisabledGroup(rimAlphaOn);
            {
                materialEditor.ShaderProperty(properties.rimAlphaMin, Styles.rimAlphaMin.text, 2);
                materialEditor.ShaderProperty(properties.rimAlphaMax, Styles.rimAlphaMax.text, 2);
                materialEditor.ShaderProperty(properties.rimAlphaEnhance, Styles.rimAlphaEnhance.text, 2);
                materialEditor.ShaderProperty(properties.transparency, Styles.transparency.text, 2);
                materialEditor.ShaderProperty(properties.minTransparency, Styles.minTransparency.text, 2);
            }
            EditorGUI.EndDisabledGroup();
        }
        public static void DoRimLightArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {            
            materialEditor.ShaderProperty(properties.rimLightOn, Styles.rimLightOn.text);
            var rimLightOn = (material.GetInt("_RimLightOn") == 0);
            EditorGUI.BeginDisabledGroup(rimLightOn);
            {
                materialEditor.ShaderProperty(properties.rimLightMin, Styles.rimLightMin.text, 2);
                materialEditor.ShaderProperty(properties.rimLightMax, Styles.rimLightMax.text, 2);
                materialEditor.ShaderProperty(properties.rimLightColor, Styles.rimLightColor.text, 2);
            }
            EditorGUI.EndDisabledGroup();
            
        }

        public static void DoTCPRimLightArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {            
            materialEditor.ShaderProperty(properties.tcp_rim_on, Styles.tcp_rim_on.text);
            var tcp_rim_on = (material.GetInt("_TCP_Rim_On") == 0);
            EditorGUI.BeginDisabledGroup(tcp_rim_on);
            {
                materialEditor.ShaderProperty(properties.tcp_rimColor, Styles.tcp_rimColor.text, 2);                
                materialEditor.ShaderProperty(properties.tcp_rimMin, Styles.tcp_rimMin.text, 2);
                materialEditor.ShaderProperty(properties.tcp_rimMax, Styles.tcp_rimMax.text, 2);                                
                materialEditor.ShaderProperty(properties.tcp_rimStrength, Styles.tcp_rimStrength.text, 2);

                materialEditor.ShaderProperty(properties.tcp_rimOffset_on, Styles.tcp_rimOffset_on.text);
                var tcp_rimOffset_on = (material.GetInt("_TCP_RimOffset_On") == 0);
                EditorGUI.BeginDisabledGroup(tcp_rimOffset_on);
                {
                    materialEditor.ShaderProperty(properties.tcp_rimOffsetX, Styles.tcp_rimOffsetX.text, 2);
                    materialEditor.ShaderProperty(properties.tcp_rimOffsetY, Styles.tcp_rimOffsetY.text, 2);
                    materialEditor.ShaderProperty(properties.tcp_rimOffsetZ, Styles.tcp_rimOffsetZ.text, 2);
                    EditorGUI.EndDisabledGroup();
                }
            }
            EditorGUI.EndDisabledGroup();
            
        }

        public static void DoSharpLightChangeArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {            
            materialEditor.ShaderProperty(properties.sharpLightChangeOn, Styles.sharpLightChangeOn.text);
            var sharpLightChangeOn = (material.GetInt("_SharpLightChangeOn") == 0);
            EditorGUI.BeginDisabledGroup(sharpLightChangeOn);
            {                
                materialEditor.ShaderProperty(properties.highLightColor, Styles.highLightColor.text, 2);
                materialEditor.ShaderProperty(properties.shadowLightColor, Styles.shadowLightColor.text, 2);

                // DoWrapLightArea
                    materialEditor.ShaderProperty(properties.wrapLightingOn, Styles.wrapLightingOn.text);
                    var wrapLightingOn = (material.GetInt("_WrapLightingOn") == 0);
                    EditorGUI.BeginDisabledGroup(wrapLightingOn);
                    {                    
                        materialEditor.ShaderProperty(properties.threshold1, Styles.threshold1.text, 2);
                        materialEditor.ShaderProperty(properties.threshold2, Styles.threshold2.text, 2);
                        materialEditor.ShaderProperty(properties.attenuationControl, Styles.attenuationControl.text, 2);
                    }
                    EditorGUI.EndDisabledGroup();
                // DoWrapLightArea
            }
            EditorGUI.EndDisabledGroup();
        }

        public static void DoWrapLightArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {            
            materialEditor.ShaderProperty(properties.sharpLightChangeOn, Styles.sharpLightChangeOn.text);
            var sharpLightChangeOn = (material.GetInt("_SharpLightChangeOn") == 0);
            EditorGUI.BeginDisabledGroup(sharpLightChangeOn);
            {
                materialEditor.ShaderProperty(properties.highLightColor, Styles.highLightColor.text, 2);
                materialEditor.ShaderProperty(properties.shadowLightColor, Styles.shadowLightColor.text, 2);
            }
            EditorGUI.EndDisabledGroup();
        }
        public static void DoAnistropicArea(LitProperties properties, MaterialEditor materialEditor, Material material)
        {            
            materialEditor.ShaderProperty(properties.anistropic, Styles.anistropic.text);
            var anistropic = (material.GetInt("_AnistropicOn") == 0);
            EditorGUI.BeginDisabledGroup(anistropic);
            {                
                if (properties.anisNoiseTex != null)
                {
                    materialEditor.TexturePropertySingleLine(Styles.anisNoiseTex, properties.anisNoiseTex);
                    if (material.GetTexture("_AnisNoiseTex"))
                    {
                        materialEditor.TextureScaleOffsetProperty(properties.anisNoiseTex);
                        materialEditor.ShaderProperty(properties.shiftX, Styles.shiftX.text, 2);
                        materialEditor.ShaderProperty(properties.shiftY, Styles.shiftY.text, 2);
                        materialEditor.ShaderProperty(properties.offset, Styles.offset.text, 2);
                        materialEditor.ShaderProperty(properties.rotate, Styles.rotate.text, 2);
                    }
                    else
                    {
                        material.SetTexture("_AnisNoiseTex", null);
                    }
                }            

                

                materialEditor.ShaderProperty(properties.specularColor, Styles.specularColor.text, 2);
                materialEditor.ShaderProperty(properties.roughnessX, Styles.roughnessX.text, 2);
                materialEditor.ShaderProperty(properties.roughnessY, Styles.roughnessY.text, 2);
                // materialEditor.ShaderProperty(properties.lightDirX, Styles.lightDirX.text, 2);
                // materialEditor.ShaderProperty(properties.lightDirY, Styles.lightDirY.text, 2);
                // materialEditor.ShaderProperty(properties.lightDirZ, Styles.lightDirZ.text, 2);
            }
            EditorGUI.EndDisabledGroup();            
        }
        static void TextureLayout(MaterialEditor materialEditor,GUIContent content, MaterialProperty propert1, MaterialProperty propert2 = null)
        {
            GUILayout.BeginHorizontal();
            GUILayout.Space(20);
            if (propert2 != null)
                materialEditor.TexturePropertySingleLine(content, propert1, propert2);
            else
                materialEditor.TexturePropertySingleLine(content, propert1);
            GUILayout.EndHorizontal();
        }
        static void TextureLayout0(MaterialEditor materialEditor,GUIContent content, MaterialProperty propert1, MaterialProperty propert2 = null)
        {
            GUILayout.BeginHorizontal();
            GUILayout.Space(10);
            if (propert2 != null)
                materialEditor.TexturePropertySingleLine(content, propert1, propert2);
            else
                materialEditor.TexturePropertySingleLine(content, propert1);
            GUILayout.EndHorizontal();
        }
    }
}
