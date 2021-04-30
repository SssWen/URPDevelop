

using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEditor;


internal class SkinShaderGUI_Layer : ShaderGUI
{
    private static class Styles
    {
        public static GUIStyle optionsButton = "PaneOptions";

        public static string emptyTootip = "";
        public static GUIContent albedoText = new GUIContent("Albedo", "Albedo (RGB) and Transparency (A)");
        public static GUIContent specularText = new GUIContent("Specular[光滑度(R) 厚度图(G) 附加阴影(B)]", "光滑度(R) 曲率(G) 附加阴影(B)");
        public static GUIContent bumpMapText = new GUIContent("NormalMap", "Normal Map");
        public static GUIContent lookupText = new GUIContent("LUT", "Lookup texture");
        public static GUIContent fresnelText = new GUIContent("fresnel", "fresnel");
        public static GUIContent shadowIntensityText = new GUIContent("shadowIntensity", "shadowIntensity");
        public static GUIContent extraShadeRangeText = new GUIContent("extraShadeRange", "extraShadeRange");

        public static GUIContent shadowColorText = new GUIContent("部分阴影颜色", "_ShadowColor");
        public static GUIContent shadeColorText = new GUIContent("ShadeColor", "ShadeColor");
        public static GUIContent specularColorText = new GUIContent("高光颜色", "ShadeColor");
        public static GUIContent NN4AmbientTintText = new GUIContent("环境光", "ShadeColor");
        public static GUIContent NN4Char_LightColor1Text = new GUIContent("第1盏灯光颜色", "ShadeColor");
        public static GUIContent NN4Char_LightColor2Text = new GUIContent("第2盏灯光颜色", "ShadeColor");
        public static GUIContent NN4Char_LightDir1Text = new GUIContent("第1盏灯光方向", "");
        public static GUIContent NN4Char_LightDir2Text = new GUIContent("第2盏灯光方向", "");
        
        public static GUIContent layer0UVSetText = new GUIContent("Layer0UVSet", "Layer0 UVSet");
        public static GUIContent layer0NormalText = new GUIContent("Layer0Norma[平铺法线]", "Layer0 Normal Texture");        

        public static GUIContent layer1TexText = new GUIContent("Layer1[腮红]", "");
        public static GUIContent layer1MaskText = new GUIContent("Layer1Mask", "");
        public static GUIContent layer1ColorText = new GUIContent("Layer1Color", "");
        public static GUIContent layer1SmoothnessText = new GUIContent("Layer1Smoothness", "");
        public static GUIContent layer1MetallicText = new GUIContent("Layer1Metallic", "");        
        public static GUIContent layer1UVSetText = new GUIContent("Layer1UVSet", "Layer2 UVSet");
        public static GUIContent layer1NormalText = new GUIContent("Layer1Normal", "");
        

        public static GUIContent layer2TexText = new GUIContent("Layer2[眼影]", "");
        public static GUIContent layer2MaskText = new GUIContent("Layer2Mask", "");
        public static GUIContent layer2ColorText = new GUIContent("Layer2Color", "");
        public static GUIContent layer2SmoothnessText = new GUIContent("Layer2Smoothness", "Layer2 Smoothness");
        public static GUIContent layer2MetallicText = new GUIContent("Layer2Metallic", "Layer2 Metallic");        
        public static GUIContent layer2UVSetText = new GUIContent("Layer2UVSet", "Layer2 UVSet");
        public static GUIContent layer2NormalText = new GUIContent("Layer2Normal", "Layer2 Normal Texture");
        
        

        public static GUIContent layer3TexText = new GUIContent("Layer3[眉毛]", "");
        public static GUIContent layer3MaskText = new GUIContent("Layer3Mask", "");
        public static GUIContent layer3ColorText = new GUIContent("Layer3Color", "");
        public static GUIContent layer3SmoothnessText = new GUIContent("Layer3Smoothness", "");
        public static GUIContent layer3MetallicText = new GUIContent("Layer3Metallic", "");
        public static GUIContent layer3UVSetText = new GUIContent("Layer3UVSet", "");
        public static GUIContent layer3NormalText = new GUIContent("Layer3Normal", "");
        

        public static GUIContent layer4TexText = new GUIContent("Layer4[眼线]", "");
        public static GUIContent layer4MaskText = new GUIContent("Layer4Mask", "");
        public static GUIContent layer4ColorText = new GUIContent("Layer4Color", "");
        public static GUIContent layer4SmoothnessText = new GUIContent("Layer4Smoothness", "");
        public static GUIContent layer4MetallicText = new GUIContent("Layer4Metallic", "");
        public static GUIContent layer4UVSetText = new GUIContent("Layer4UVSet", "");
        public static GUIContent layer4NormalText = new GUIContent("Layer4Normal", "");
        

        public static GUIContent layer5TexText = new GUIContent("Layer5[口红]", "Layer5 Texture");
        public static GUIContent layer5MaskText = new GUIContent("Layer5Mask", "");
        public static GUIContent layer5ColorText = new GUIContent("Layer5Color", "Layer5 Color");
        public static GUIContent layer5SmoothnessText = new GUIContent("Layer5Smoothness", "Layer5 Smoothness");
        public static GUIContent layer5MetallicText = new GUIContent("Layer5Metallic", "Layer5 Metallic");
        public static GUIContent layer5UVSetText = new GUIContent("Layer5UVSet", "Layer5 UVSet");
        public static GUIContent layer5NormalText = new GUIContent("Layer5Normal", "Layer5 Normal Texture");
        

        public static GUIContent layer6TexText = new GUIContent("Layer6[面饰]", "Layer6 Texture");
        public static GUIContent layer6MaskText = new GUIContent("Layer6Mask", "");
        public static GUIContent layer6ColorText = new GUIContent("Layer6Color", "Layer6 Color");
        public static GUIContent layer6SmoothnessText = new GUIContent("Layer6Smoothness", "Layer6 Smoothness");
        public static GUIContent layer6MetallicText = new GUIContent("Layer6Metallic", "Layer6 Metallic");
        public static GUIContent layer6UVSetText = new GUIContent("Layer6UVSet", "Layer6 UVSet");
        public static GUIContent layer6NormalText = new GUIContent("Layer6Normal", "Layer6 Normal Texture");
        
        
        public static GUIContent layer7TexText = new GUIContent("Layer7[待定]", "Layer7 Texture");
        public static GUIContent layer7MaskText = new GUIContent("Layer7Mask", "");
        public static GUIContent layer7ColorText = new GUIContent("Layer7Color", "Layer7 Color");
        public static GUIContent layer7SmoothnessText = new GUIContent("Layer7Smoothness", "Layer7 Smoothness");
        public static GUIContent layer7MetallicText = new GUIContent("Layer7Metallic", "Layer7 Metallic");
        public static GUIContent layer7UVSetText = new GUIContent("Layer7UVSet", "Layer7 UVSet");
        public static GUIContent layer7NormalText = new GUIContent("Layer7Normal", "Layer7 Normal Texture");
        


        public static string primaryMapsText = "主要贴图";
        public static string otherText = "其他参数";
        public static string colorText = "颜色参数";
        public static string layerText = "妆容层级";
        
    }

    
    MaterialProperty albedoMap = null;    
    // --
    MaterialProperty specularTex = null;
    
    MaterialProperty bumpMap = null;
    MaterialProperty bumpMapScale = null;   
    MaterialProperty lutTex = null;

    // -- 
    MaterialProperty fresnel = null;
    MaterialProperty shadowIntensity = null;
    MaterialProperty extraShadeRange = null;
    

    // color 
    MaterialProperty _BaseColor = null;
    MaterialProperty _ShadowColor = null;
    MaterialProperty _ShadeColor = null;
    MaterialProperty _SpecularColor = null;
    MaterialProperty _NN4AmbientTint = null;
    MaterialProperty _NN4Char_LightColor1 = null;
    MaterialProperty _NN4Char_LightColor2 = null;    
    

    // vector4
    MaterialProperty _NN4Char_LightDir1 = null;
    MaterialProperty _NN4Char_LightDir2 = null;


    
    MaterialProperty layer0UVSet = null;
    MaterialProperty layer0Normal = null;
    MaterialProperty layer0NormalScale = null;    

    MaterialProperty layer1Tex = null;
    MaterialProperty layer1Mask = null;
    MaterialProperty layer1Color = null;
    MaterialProperty layer1Smoothness = null;
    MaterialProperty layer1Metallic = null;
    MaterialProperty layer1UVSet = null;
    MaterialProperty layer1Normal= null;    
    MaterialProperty layer1NormalScale = null;    
    

    MaterialProperty layer2Tex = null;
    MaterialProperty layer2Mask = null;
    MaterialProperty layer2Color = null;
    MaterialProperty layer2Smoothness = null;
    MaterialProperty layer2Metallic = null;
    MaterialProperty layer2UVSet = null;
    MaterialProperty layer2Normal = null;
    MaterialProperty layer2NormalScale = null;
    

    MaterialProperty layer3Tex = null;
    MaterialProperty layer3Mask = null;
    MaterialProperty layer3Color = null;
    MaterialProperty layer3Smoothness = null;
    MaterialProperty layer3Metallic = null;
    MaterialProperty layer3UVSet = null;
    MaterialProperty layer3Normal = null;
    MaterialProperty layer3NormalScale = null;
    

    MaterialProperty layer4Tex = null;
    MaterialProperty layer4Mask = null;
    MaterialProperty layer4Color = null;
    MaterialProperty layer4Smoothness = null;
    MaterialProperty layer4Metallic = null;
    MaterialProperty layer4UVSet = null;
    MaterialProperty layer4Normal = null;
    MaterialProperty layer4NormalScale = null;


    MaterialProperty layer5Tex = null;
    MaterialProperty layer5Mask = null;
    MaterialProperty layer5Color = null;
    MaterialProperty layer5Smoothness = null;
    MaterialProperty layer5Metallic = null;
    MaterialProperty layer5UVSet = null;
    MaterialProperty layer5Normal = null;
    MaterialProperty layer5NormalScale = null;


    MaterialProperty layer6Tex = null;
    MaterialProperty layer6Mask = null;
    MaterialProperty layer6Color = null;
    MaterialProperty layer6Smoothness = null;
    MaterialProperty layer6Metallic = null;
    MaterialProperty layer6UVSet = null;
    MaterialProperty layer6Normal = null;
    MaterialProperty layer6NormalScale = null;


    MaterialProperty layer7Tex = null;
    MaterialProperty layer7Mask = null;
    MaterialProperty layer7Color = null;
    MaterialProperty layer7Smoothness = null;
    MaterialProperty layer7Metallic = null;
    MaterialProperty layer7UVSet = null;
    MaterialProperty layer7Normal = null;
    MaterialProperty layer7NormalScale = null;    
    
    
    MaterialEditor m_MaterialEditor;    

    bool m_FirstTimeApply = true;

    public void FindProperties(MaterialProperty[] props)
    {
        // texture
        albedoMap = FindProperty("_MainTexT", props);
        specularTex = FindProperty("_SpecularTex", props);
        bumpMap = FindProperty("_NormalMap", props);
        bumpMapScale = FindProperty("_NormalMapScale", props);
        lutTex = FindProperty("_LUTTex", props);

        // float
        fresnel = FindProperty("_Fresnel", props);
        shadowIntensity = FindProperty("_ShadowIntensity", props);
        extraShadeRange = FindProperty("_ExtraShadeRange", props);

        // color
        _BaseColor = FindProperty("_BaseColorT", props);
        _ShadowColor = FindProperty("_ShadowColor", props);
        _ShadeColor = FindProperty("_ShadeColor", props);
        _SpecularColor = FindProperty("_SpecularColor", props);
        _NN4AmbientTint = FindProperty("_NN4AmbientTint", props);
        _NN4Char_LightColor1 = FindProperty("_NN4Char_LightColor1", props);
        _NN4Char_LightColor2 = FindProperty("_NN4Char_LightColor2", props);
        

        // vector4
        _NN4Char_LightDir1 = FindProperty("_NN4Char_LightDir1", props);
        _NN4Char_LightDir2 = FindProperty("_NN4Char_LightDir2", props);

        // layer
        
                
        
        layer0UVSet = FindProperty("_Layer0UVSet", props);
        layer0Normal = FindProperty("_Layer0Normal", props);
        layer0NormalScale = FindProperty("_Layer0NormalScale", props);        

        layer1Tex = FindProperty("_Layer1Tex", props);
        layer1Mask = FindProperty("_Layer1Mask", props);
        layer1UVSet = FindProperty("_Layer1UVSet", props);
        layer1Normal = FindProperty("_Layer1Normal", props);
        layer1NormalScale = FindProperty("_Layer1NormalScale", props);
        layer1Color = FindProperty("_Layer1Color", props);
        layer1Smoothness = FindProperty("_Layer1Smoothness", props);
        layer1Metallic = FindProperty("_Layer1Metallic", props);
        // layer1BlendMode = FindProperty("_Layer1BlendMode", props);

        layer2Tex = FindProperty("_Layer2Tex", props);
        layer2Mask = FindProperty("_Layer2Mask", props);
        layer2UVSet = FindProperty("_Layer2UVSet", props);
        layer2Normal = FindProperty("_Layer2Normal", props);
        layer2NormalScale = FindProperty("_Layer2NormalScale", props);
        layer2Color = FindProperty("_Layer2Color", props);
        layer2Smoothness = FindProperty("_Layer2Smoothness", props);
        layer2Metallic = FindProperty("_Layer2Metallic", props);
        // layer2BlendMode = FindProperty("_Layer2BlendMode", props);

        layer3Tex = FindProperty("_Layer3Tex", props);
        layer3Mask = FindProperty("_Layer3Mask", props);
        layer3Color = FindProperty("_Layer3Color", props);
        layer3Smoothness = FindProperty("_Layer3Smoothness", props);
        layer3Metallic = FindProperty("_Layer3Metallic", props);
        layer3UVSet = FindProperty("_Layer3UVSet", props);
        layer3Normal = FindProperty("_Layer3Normal", props);
        layer3NormalScale = FindProperty("_Layer3NormalScale", props);
        // layer3BlendMode = FindProperty("_Layer3BlendMode", props);

        layer4Tex = FindProperty("_Layer4Tex", props);
        layer4Mask = FindProperty("_Layer4Mask", props);
        layer4Color = FindProperty("_Layer4Color", props);
        layer4Smoothness = FindProperty("_Layer4Smoothness", props);
        layer4Metallic = FindProperty("_Layer4Metallic", props);
        layer4UVSet = FindProperty("_Layer4UVSet", props);
        layer4Normal = FindProperty("_Layer4Normal", props);
        layer4NormalScale = FindProperty("_Layer4NormalScale", props);
        // layer4BlendMode = FindProperty("_Layer4BlendMode", props);

        layer5Tex = FindProperty("_Layer5Tex", props);
        layer5Mask = FindProperty("_Layer5Mask", props);
        layer5Color = FindProperty("_Layer5Color", props);
        layer5Smoothness = FindProperty("_Layer5Smoothness", props);
        layer5Metallic = FindProperty("_Layer5Metallic", props);
        layer5UVSet = FindProperty("_Layer5UVSet", props);
        layer5Normal = FindProperty("_Layer5Normal", props);
        layer5NormalScale = FindProperty("_Layer5NormalScale", props);
        // layer5BlendMode = FindProperty("_Layer5BlendMode", props);

        layer6Tex = FindProperty("_Layer6Tex", props);
        layer6Mask = FindProperty("_Layer6Mask", props);
        layer6Color = FindProperty("_Layer6Color", props);
        layer6Smoothness = FindProperty("_Layer6Smoothness", props);
        layer6Metallic = FindProperty("_Layer6Metallic", props);
        layer6UVSet = FindProperty("_Layer6UVSet", props);
        layer6Normal = FindProperty("_Layer6Normal", props);
        layer6NormalScale = FindProperty("_Layer6NormalScale", props);
        // layer6BlendMode = FindProperty("_Layer6BlendMode", props);

        layer7Tex = FindProperty("_Layer7Tex", props);
        layer7Mask = FindProperty("_Layer7Mask", props);
        layer7Color = FindProperty("_Layer7Color", props);
        layer7Smoothness = FindProperty("_Layer7Smoothness", props);
        layer7Metallic = FindProperty("_Layer7Metallic", props);
        layer7UVSet = FindProperty("_Layer7UVSet", props);
        layer7Normal = FindProperty("_Layer7Normal", props);
        layer7NormalScale = FindProperty("_Layer7NormalScale", props);        

    }

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        FindProperties(props); // MaterialProperties can be animated so we do not cache them but fetch them every event to ensure animated values are updated correctly
        m_MaterialEditor = materialEditor;
        Material material = materialEditor.target as Material;

        // Make sure that needed setup (ie keywords/renderqueue) are set up if we're switching some existing
        // material to a standard shader.
        // Do this before any GUI code has been issued to prevent layout issues in subsequent GUILayout statements (case 780071)
        if (m_FirstTimeApply)
        {            
            int renderQueue = material.renderQueue;
            MaterialChanged(material);
            material.renderQueue = renderQueue;
            m_FirstTimeApply = false;
        }
        ShaderPropertiesGUI(material);
        // GUILayout.EndVertical();
    }

    public void ShaderPropertiesGUI(Material material)
    {
        // Use default labelWidth
        EditorGUIUtility.labelWidth = 0f;

        // Detect any changes to the material
        EditorGUI.BeginChangeCheck();
        {
            // GUILayout.Space(8f);
            // GUILayout.Space(4f);
            
            // Primary properties
            GUILayout.Label(Styles.primaryMapsText, EditorStyles.boldLabel);
            DoTextureArea(material);
            GUILayout.Label(Styles.otherText, EditorStyles.boldLabel);
            DoFloatArea(material);
            GUILayout.Label(Styles.colorText, EditorStyles.boldLabel);
            DoColorArea(material);
            GUILayout.Label(Styles.layerText, EditorStyles.boldLabel);
            DoLayerArea(material);
            
        }
       
        if (EditorGUI.EndChangeCheck())
        {           
            SetMaterialKeywords(material);
        }

        EditorGUILayout.Space();                
        
    }

    void DoTextureArea(Material material)
    {
        m_MaterialEditor.TexturePropertySingleLine(Styles.albedoText, albedoMap, _BaseColor);
        m_MaterialEditor.TexturePropertySingleLine(Styles.specularText, specularTex);
        m_MaterialEditor.TexturePropertySingleLine(Styles.bumpMapText,  bumpMap, bumpMapScale);
        m_MaterialEditor.TexturePropertySingleLine(Styles.lookupText, lutTex);        
    }


    void DoFloatArea(Material material)
    {
       m_MaterialEditor.ShaderProperty(fresnel, Styles.fresnelText.text);
       m_MaterialEditor.ShaderProperty(shadowIntensity, Styles.shadowIntensityText.text);
       m_MaterialEditor.ShaderProperty(extraShadeRange, Styles.extraShadeRangeText.text);
    }

    void DoColorArea(Material material)
    {
        m_MaterialEditor.ShaderProperty(_ShadowColor, Styles.shadowColorText.text);
        m_MaterialEditor.ShaderProperty(_ShadeColor, Styles.shadeColorText.text);
        m_MaterialEditor.ShaderProperty(_SpecularColor, Styles.specularColorText.text);
        m_MaterialEditor.ShaderProperty(_NN4AmbientTint, Styles.NN4AmbientTintText.text);
        m_MaterialEditor.ShaderProperty(_NN4Char_LightColor1, Styles.NN4Char_LightColor1Text.text);
        m_MaterialEditor.ShaderProperty(_NN4Char_LightColor2, Styles.NN4Char_LightColor2Text.text);
        m_MaterialEditor.ShaderProperty(_NN4Char_LightDir1, Styles.NN4Char_LightDir1Text.text);
        m_MaterialEditor.ShaderProperty(_NN4Char_LightDir2, Styles.NN4Char_LightDir2Text.text);
    }
    // void TextureLayout(GUIContent content, params MaterialProperty[] property)
    // {
    //     GUILayout.BeginHorizontal();        
    //     GUILayout.Space(10);
        
    //         m_MaterialEditor.TexturePropertySingleLine(content, property);
    //     GUILayout.EndHorizontal();
    // }
    void TextureLayout(GUIContent content, MaterialProperty propert1, MaterialProperty propert2 = null)
    {
        GUILayout.BeginHorizontal();        
        GUILayout.Space(10);
        if (propert2 != null)
            m_MaterialEditor.TexturePropertySingleLine(content, propert1,propert2);
        else
            m_MaterialEditor.TexturePropertySingleLine(content, propert1);
        GUILayout.EndHorizontal();
    }
    void DoLayerArea(Material material)
    {
                
        m_MaterialEditor.TexturePropertySingleLine(Styles.layer0NormalText, layer0Normal, layer0NormalScale);         
        if (material.GetTexture("_Layer0Normal"))
        {            
            m_MaterialEditor.TextureScaleOffsetProperty(layer0Normal);  
            m_MaterialEditor.ShaderProperty(layer0UVSet, Styles.layer0UVSetText.text, 2);
            
        }

        m_MaterialEditor.TexturePropertySingleLine(Styles.layer1TexText, layer1Tex);    

        if (material.GetTexture("_Layer1Tex"))
        {    
            TextureLayout(Styles.layer1NormalText, layer1Normal, layer1NormalScale); 
            TextureLayout(Styles.layer1MaskText, layer2Mask);  
            m_MaterialEditor.TextureScaleOffsetProperty(layer1Tex);
            m_MaterialEditor.ShaderProperty(layer1Color, Styles.layer1ColorText.text, 2);
            m_MaterialEditor.ShaderProperty(layer1Smoothness, Styles.layer1SmoothnessText.text, 2);
            m_MaterialEditor.ShaderProperty(layer1Metallic, Styles.layer1MetallicText.text, 2);            
            m_MaterialEditor.ShaderProperty(layer1UVSet, Styles.layer1UVSetText.text, 2);                    
        }
        else
        {        
            material.SetTexture("_Layer1Normal", null);
            material.SetTexture("_Layer1Mask", null);            
        }

        m_MaterialEditor.TexturePropertySingleLine(Styles.layer2TexText, layer2Tex);         
        if (material.GetTexture("_Layer2Tex"))
        {    
            TextureLayout(Styles.layer2NormalText, layer2Normal, layer2NormalScale); 
            TextureLayout(Styles.layer2MaskText, layer2Mask);  
            
            m_MaterialEditor.TextureScaleOffsetProperty(layer2Tex);
            m_MaterialEditor.ShaderProperty(layer2Color, Styles.layer2ColorText.text, 2);
            m_MaterialEditor.ShaderProperty(layer2Smoothness, Styles.layer2SmoothnessText.text, 2);
            m_MaterialEditor.ShaderProperty(layer2Metallic, Styles.layer2MetallicText.text, 2);    
            m_MaterialEditor.ShaderProperty(layer2UVSet, Styles.layer2UVSetText.text, 2);        
            // m_MaterialEditor.ShaderProperty(layer2BlendMode, Styles.layer2BlendModeText.text, 2); 
        }
        else
        {        
            material.SetTexture("_Layer2Normal", null);
            material.SetTexture("_Layer2Mask", null);            
        }

        m_MaterialEditor.TexturePropertySingleLine(Styles.layer3TexText, layer3Tex);    
       
        if (material.GetTexture("_Layer3Tex"))
        {
            TextureLayout(Styles.layer3NormalText, layer3Normal, layer3NormalScale);  
            TextureLayout(Styles.layer3MaskText, layer3Mask); 
            m_MaterialEditor.TextureScaleOffsetProperty(layer3Tex);
            m_MaterialEditor.ShaderProperty(layer3Color, Styles.layer3ColorText.text, 2);
            m_MaterialEditor.ShaderProperty(layer3Smoothness, Styles.layer3SmoothnessText.text, 2);
            m_MaterialEditor.ShaderProperty(layer3Metallic, Styles.layer3MetallicText.text, 2);    
            m_MaterialEditor.ShaderProperty(layer3UVSet, Styles.layer3UVSetText.text, 2);        
            // m_MaterialEditor.ShaderProperty(layer3BlendMode, Styles.layer3BlendModeText.text, 2); 
        }
        else
        {        
            material.SetTexture("_Layer3Normal", null);
            material.SetTexture("_Layer3Mask", null);            
        }

        m_MaterialEditor.TexturePropertySingleLine(Styles.layer4TexText, layer4Tex);    

        if (material.GetTexture("_Layer4Tex"))
        {
            TextureLayout(Styles.layer4NormalText, layer4Normal, layer4NormalScale); 
            TextureLayout(Styles.layer4MaskText, layer4Mask);  
            m_MaterialEditor.TextureScaleOffsetProperty(layer4Tex);
            m_MaterialEditor.ShaderProperty(layer4Color, Styles.layer4ColorText.text, 2);
            m_MaterialEditor.ShaderProperty(layer4Smoothness, Styles.layer4SmoothnessText.text, 2);
            m_MaterialEditor.ShaderProperty(layer4Metallic, Styles.layer4MetallicText.text, 2);    
            m_MaterialEditor.ShaderProperty(layer4UVSet, Styles.layer4UVSetText.text, 2);        
            // m_MaterialEditor.ShaderProperty(layer4BlendMode, Styles.layer4BlendModeText.text, 2); 
        }
        else
        {        
            material.SetTexture("_Layer4Normal", null);
            material.SetTexture("_Layer4Mask", null);            
        }

        m_MaterialEditor.TexturePropertySingleLine(Styles.layer5TexText, layer5Tex);    

        if (material.GetTexture("_Layer5Tex"))
        {
            TextureLayout(Styles.layer5NormalText, layer5Normal, layer5NormalScale); 
            TextureLayout(Styles.layer5MaskText, layer5Mask);   
            m_MaterialEditor.TextureScaleOffsetProperty(layer5Tex);
            m_MaterialEditor.ShaderProperty(layer5Color, Styles.layer5ColorText.text, 2);
            m_MaterialEditor.ShaderProperty(layer5Smoothness, Styles.layer5SmoothnessText.text, 2);
            m_MaterialEditor.ShaderProperty(layer5Metallic, Styles.layer5MetallicText.text, 2);    
            m_MaterialEditor.ShaderProperty(layer5UVSet, Styles.layer5UVSetText.text, 2);        
            // m_MaterialEditor.ShaderProperty(layer5BlendMode, Styles.layer5BlendModeText.text, 2); 
        }
        else
        {        
            material.SetTexture("_Layer5Normal", null);
            material.SetTexture("_Layer5Mask", null);            
        }

        m_MaterialEditor.TexturePropertySingleLine(Styles.layer6TexText, layer6Tex);    
  
        if (material.GetTexture("_Layer6Tex"))
        {
            TextureLayout(Styles.layer6NormalText, layer6Normal, layer6NormalScale); 
            TextureLayout(Styles.layer6MaskText, layer6Mask);     
            m_MaterialEditor.TextureScaleOffsetProperty(layer6Tex);
            m_MaterialEditor.ShaderProperty(layer6Color, Styles.layer6ColorText.text, 2);
            m_MaterialEditor.ShaderProperty(layer6Smoothness, Styles.layer6SmoothnessText.text, 2);
            m_MaterialEditor.ShaderProperty(layer6Metallic, Styles.layer6MetallicText.text, 2);    
            m_MaterialEditor.ShaderProperty(layer6UVSet, Styles.layer6UVSetText.text, 2);        
            // m_MaterialEditor.ShaderProperty(layer6BlendMode, Styles.layer6BlendModeText.text, 2); 
        }
        else
        {        
            material.SetTexture("_Layer6Normal", null);
            material.SetTexture("_Layer6Mask", null);            
        }

        m_MaterialEditor.TexturePropertySingleLine(Styles.layer7TexText, layer7Tex);    
  
        if (material.GetTexture("_Layer7Tex"))
        {
            TextureLayout(Styles.layer7NormalText, layer7Normal, layer7NormalScale); 
            TextureLayout(Styles.layer7MaskText, layer7Mask);     
            m_MaterialEditor.TextureScaleOffsetProperty(layer7Tex);
            m_MaterialEditor.ShaderProperty(layer7Color, Styles.layer7ColorText.text, 2);
            m_MaterialEditor.ShaderProperty(layer7Smoothness, Styles.layer7SmoothnessText.text, 2);
            m_MaterialEditor.ShaderProperty(layer7Metallic, Styles.layer7MetallicText.text, 2);    
            m_MaterialEditor.ShaderProperty(layer7UVSet, Styles.layer7UVSetText.text, 2);        
            // m_MaterialEditor.ShaderProperty(layer7BlendMode, Styles.layer7BlendModeText.text, 2); 
        }
        else
        {        
            material.SetTexture("_Layer7Normal", null);
            material.SetTexture("_Layer7Mask", null);            
        }

    }        

    static void SetMaterialKeywords(Material material)
    {        
        SetKeyword(material, "_NORMALMAP", material.GetTexture("_NormalMap"));

        SetKeyword(material, "_LAYER_1_TEX", material.GetTexture("_Layer1Tex"));
        SetKeyword(material, "_LAYER_2_TEX", material.GetTexture("_Layer2Tex"));
        SetKeyword(material, "_LAYER_3_TEX", material.GetTexture("_Layer3Tex"));
        SetKeyword(material, "_LAYER_4_TEX", material.GetTexture("_Layer4Tex"));
        SetKeyword(material, "_LAYER_5_TEX", material.GetTexture("_Layer5Tex"));
        SetKeyword(material, "_LAYER_6_TEX", material.GetTexture("_Layer6Tex"));
        SetKeyword(material, "_LAYER_7_TEX", material.GetTexture("_Layer7Tex"));      

        SetKeyword(material, "_LAYER_1_MASK", material.GetTexture("_Layer1Mask"));
        SetKeyword(material, "_LAYER_2_MASK", material.GetTexture("_Layer2Mask"));
        SetKeyword(material, "_LAYER_3_MASK", material.GetTexture("_Layer3Mask"));
        SetKeyword(material, "_LAYER_4_MASK", material.GetTexture("_Layer4Mask"));
        SetKeyword(material, "_LAYER_5_MASK", material.GetTexture("_Layer5Mask"));
        SetKeyword(material, "_LAYER_6_MASK", material.GetTexture("_Layer6Mask"));
        SetKeyword(material, "_LAYER_7_MASK", material.GetTexture("_Layer7Mask"));
        
        SetKeyword(material, "_LAYER_0_NORMAL", material.GetTexture("_Layer0Normal"));
        SetKeyword(material, "_LAYER_1_NORMAL", material.GetTexture("_Layer1Normal"));
        SetKeyword(material, "_LAYER_2_NORMAL", material.GetTexture("_Layer2Normal"));
        SetKeyword(material, "_LAYER_3_NORMAL", material.GetTexture("_Layer3Normal"));
        SetKeyword(material, "_LAYER_4_NORMAL", material.GetTexture("_Layer4Normal"));
        SetKeyword(material, "_LAYER_5_NORMAL", material.GetTexture("_Layer5Normal"));
        SetKeyword(material, "_LAYER_6_NORMAL", material.GetTexture("_Layer6Normal"));
        SetKeyword(material, "_LAYER_7_NORMAL", material.GetTexture("_Layer7Normal"));
        

        // set key for layer uv set
        SetKeyword(material, "_Layer0UVSet_0", material.GetFloat("_Layer0UVSet") == 0);
        SetKeyword(material, "_Layer0UVSet_1", material.GetFloat("_Layer0UVSet") == 1);
        SetKeyword(material, "_Layer0UVSet_2", material.GetFloat("_Layer0UVSet") == 2);
        SetKeyword(material, "_Layer0UVSet_3", material.GetFloat("_Layer0UVSet") == 3);

        SetKeyword(material, "_Layer1UVSet_0", material.GetFloat("_Layer1UVSet") == 0);
        SetKeyword(material, "_Layer1UVSet_1", material.GetFloat("_Layer1UVSet") == 1);
        SetKeyword(material, "_Layer1UVSet_2", material.GetFloat("_Layer1UVSet") == 2);
        SetKeyword(material, "_Layer1UVSet_3", material.GetFloat("_Layer1UVSet") == 3);

        SetKeyword(material, "_Layer2UVSet_0", material.GetFloat("_Layer2UVSet") == 0);
        SetKeyword(material, "_Layer2UVSet_1", material.GetFloat("_Layer2UVSet") == 1);
        SetKeyword(material, "_Layer2UVSet_2", material.GetFloat("_Layer2UVSet") == 2);
        SetKeyword(material, "_Layer2UVSet_3", material.GetFloat("_Layer2UVSet") == 3);

        SetKeyword(material, "_Layer3UVSet_0", material.GetFloat("_Layer3UVSet") == 0);
        SetKeyword(material, "_Layer3UVSet_1", material.GetFloat("_Layer3UVSet") == 1);
        SetKeyword(material, "_Layer3UVSet_2", material.GetFloat("_Layer3UVSet") == 2);
        SetKeyword(material, "_Layer3UVSet_3", material.GetFloat("_Layer3UVSet") == 3);

        SetKeyword(material, "_Layer4UVSet_0", material.GetFloat("_Layer4UVSet") == 0);
        SetKeyword(material, "_Layer4UVSet_1", material.GetFloat("_Layer4UVSet") == 1);
        SetKeyword(material, "_Layer4UVSet_2", material.GetFloat("_Layer4UVSet") == 2);
        SetKeyword(material, "_Layer4UVSet_3", material.GetFloat("_Layer4UVSet") == 3);

        SetKeyword(material, "_Layer5UVSet_0", material.GetFloat("_Layer5UVSet") == 0);
        SetKeyword(material, "_Layer5UVSet_1", material.GetFloat("_Layer5UVSet") == 1);
        SetKeyword(material, "_Layer5UVSet_2", material.GetFloat("_Layer5UVSet") == 2);
        SetKeyword(material, "_Layer5UVSet_3", material.GetFloat("_Layer5UVSet") == 3);

        SetKeyword(material, "_Layer6UVSet_0", material.GetFloat("_Layer6UVSet") == 0);
        SetKeyword(material, "_Layer6UVSet_1", material.GetFloat("_Layer6UVSet") == 1);
        SetKeyword(material, "_Layer6UVSet_2", material.GetFloat("_Layer6UVSet") == 2);
        SetKeyword(material, "_Layer6UVSet_3", material.GetFloat("_Layer6UVSet") == 3);   

        SetKeyword(material, "_Layer7UVSet_0", material.GetFloat("_Layer7UVSet") == 0);
        SetKeyword(material, "_Layer7UVSet_1", material.GetFloat("_Layer7UVSet") == 1);
        SetKeyword(material, "_Layer7UVSet_2", material.GetFloat("_Layer7UVSet") == 2);
        SetKeyword(material, "_Layer7UVSet_3", material.GetFloat("_Layer7UVSet") == 3);       
        

    }

    
    static void MaterialChanged(Material material)
    {
        // SetupMaterialWithBlendMode(material, (BlendMode)material.GetFloat("_Mode"));

        SetMaterialKeywords(material);
    }

    static void SetKeyword(Material m, string keyword, bool state)
    {
        if (state)
            m.EnableKeyword(keyword);
        else
            m.DisableKeyword(keyword);
    }
}
