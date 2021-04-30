#ifndef FUN_SKINTOOL_URP_INCLUDED
#define FUN_SKINTOOL_URP_INCLUDED

#define TEXTURE2D_SAMPLER(tex) TEXTURE2D(tex); SAMPLER(sampler##tex);
#define SAMPLE_TEXTURE2D_Default(textureName, uv)  SAMPLE_TEXTURE2D(textureName,sampler##textureName,uv)

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"


struct FragmentCommonData
{
    half3 diffColor, specColor;
    // Note: smoothness & oneMinusReflectivity for optimization purposes, mostly for DX9 SM2.0 level.
    // Most of the math is being done on these (1-x) values, and that saves a few precious ALU slots.
    half oneMinusReflectivity, smoothness;
    float3 normalWorld;
    float3 eyeVec;
    half alpha;
    float3 posWorld;


    half3 tangentSpaceNormal;
// #if UNITY_STANDARD_SIMPLE
//     half3 tangentSpaceNormal;
// #endif
};

half2 GetLayer0Texcoord(half4 i_tex, half4 detailUV){
	#if   _Layer0UVSet_0
		return i_tex.xy;
	#elif _Layer0UVSet_1
		return i_tex.zw;
	#elif _Layer0UVSet_2
		return detailUV.xy;	
	#elif _Layer0UVSet_3
		return detailUV.zw;	
	#else
		return i_tex.xy;
	#endif
}
half2 GetLayer1Texcoord(half4 i_tex, half4 detailUV){
	#if _Layer1UVSet_0
		return i_tex.xy;
	#elif _Layer1UVSet_1
		return i_tex.zw;
	#elif (_Layer1UVSet_2 )
		return detailUV.xy;
	#elif _Layer1UVSet_3
		return detailUV.zw;	
	#else 
		return i_tex.xy;
	#endif
}

half2 GetLayer2Texcoord(half4 i_tex, half4 detailUV){
	#if _Layer2UVSet_0
		return i_tex.xy;
	#elif _Layer2UVSet_1
		return i_tex.zw;
	#elif _Layer2UVSet_2
		return detailUV.xy;	
	#elif _Layer2UVSet_3
		return detailUV.zw;	
	#else 
		return i_tex.xy;
	#endif
}


half2 GetLayer3Texcoord(half4 i_tex, half4 detailUV){
	#if _Layer3UVSet_0
		return i_tex.xy;
	#elif _Layer3UVSet_1
		return i_tex.zw;
	#elif _Layer3UVSet_2
		return detailUV.xy;
	#elif _Layer3UVSet_3
		return detailUV.zw;
	#else 
		return i_tex.xy;
	#endif
}


half2 GetLayer4Texcoord(half4 i_tex, half4 detailUV){
	#if _Layer4UVSet_0
		return i_tex.xy;
	#elif _Layer4UVSet_1
		return i_tex.zw;
	#elif _Layer4UVSet_2
		return detailUV.xy;
	#elif _Layer4UVSet_3
		return detailUV.zw;
	#else 
		return i_tex.xy;
	#endif
}


half2 GetLayer5Texcoord(half4 i_tex, half4 detailUV){
	#if _Layer5UVSet_0
		return i_tex.xy;
	#elif _Layer5UVSet_1
		return i_tex.zw;
	#elif _Layer5UVSet_2
		return detailUV.xy;
	#elif _Layer5UVSet_3
		return detailUV.zw;
	#else 
		return i_tex.xy;
	#endif
}


half2 GetLayer6Texcoord(half4 i_tex, half4 detailUV){
	#if _Layer6UVSet_0
		return i_tex.xy;
	#elif _Layer6UVSet_1
		return i_tex.zw;
	#elif _Layer6UVSet_2
		return detailUV.xy;
	#elif _Layer6UVSet_3
		return detailUV.zw;
	#else 
		return i_tex.xy;
	#endif
}


half2 GetLayer7Texcoord(half4 i_tex, half4 detailUV){
	#if _Layer7UVSet_0
		return i_tex.xy;
	#elif _Layer7UVSet_1
		return i_tex.zw;
	#elif _Layer7UVSet_2
		return detailUV.xy;
	#elif _Layer7UVSet_3
		return detailUV.zw;	
	#else 
		return i_tex.xy;
	#endif
}

half2 GetLayer0Mask(half2 layer0UV){
	#if _LAYER_0_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer0Tex, layer0UV).a;
		return half2(lerp(1,0,step(a,0)), a);		
	#else
		return half2(1,1);
	#endif
}

half2 GetLayer1Mask(half2 layer1UV){
	#if _LAYER_1_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer1Tex, layer1UV).a;
		return half2(lerp(1,0,step(a,0)), a);		
	#else
		return half2(1,1);
	#endif
}

half2 GetLayer2Mask(half2 layer2UV){
	#if _LAYER_2_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer2Tex, layer2UV).a;
		return half2(lerp(1,0,step(a,0)), a);
	#else
		return half2(1,1);
	#endif
}


half2 GetLayer3Mask(half2 layer3UV){
	#if _LAYER_3_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer3Tex, layer3UV).a;
		return half2(lerp(1,0,step(a,0)), a);	
	#else
		return half2(1,1);
	#endif
}


half2 GetLayer4Mask(half2 layer4UV){
	#if _LAYER_4_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer4Tex, layer4UV).a;
		return half2(lerp(1,0,step(a,0)), a);	
	#else
		return half2(1,1);
	#endif
}

half2 GetLayer5Mask(half2 layer5UV){
	#if _LAYER_5_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer5Tex, layer5UV).a;
		return half2(lerp(1,0,step(a,0)), a);	
	#else
		return half2(1,1);
	#endif
}

half2 GetLayer6Mask(half2 layer6UV){
	#if _LAYER_6_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer6Tex, layer6UV).a;
		return half2(lerp(1,0,step(a,0)), a);	
	#else
		return half2(1,1);
	#endif
}

half2 GetLayer7Mask(half2 layer7UV){
	#if _LAYER_7_TEX 
		half a = SAMPLE_TEXTURE2D_Default(_Layer7Tex, layer7UV).a;
		return half2(lerp(1,0,step(a,0)), a);	
	#else
		return half2(1,1);
	#endif
}


// 漫反射比例 = 1 - 反射比例 
inline half OneMinusReflectivityFromMetallic(half metallic)
{
    // We'll need oneMinusReflectivity, so
    //   1-reflectivity = 1-lerp(dielectricSpec, 1, metallic) = lerp(1-dielectricSpec, 0, metallic)
    // store (1-dielectricSpec) in unity_ColorSpaceDielectricSpec.a, then
    //   1-reflectivity = lerp(alpha, 0, metallic) = alpha + metallic*(0 - alpha) =
    //                  = alpha - metallic * alpha
    // unity_ColorSpaceDielectricSpec 定义了绝缘体高光颜色喝反射率是一个经验值，Linear Space half4(0.04, 0.04, 0.04, 1.0 - 0.04)
    // Gamma Space half4(0.220916301, 0.220916301, 0.220916301, 1.0 - 0.220916301)
    half oneMinusDielectricSpec = 1-0.04;
    return oneMinusDielectricSpec - metallic * oneMinusDielectricSpec;
    // gamma空间 return 0.79*(1-metallic);  
    // Linear空间 0.96*(1-metallic); 
}

inline half3 DiffuseAndSpecularFromMetallic (half3 albedo, half metallic, out half3 specColor, out half oneMinusReflectivity)
{
    specColor = lerp (half3(0.04,0.04,0.04), albedo, metallic); 
    // 当金属度为1时候，specColor就是物体本身颜色。
    // 当金属度为0的时候,specColor几乎没有, 非金属的东西基本是diffuseColor。
    oneMinusReflectivity = OneMinusReflectivityFromMetallic(metallic);
    return albedo ; // albedo * 漫反射比例
    // return albedo * oneMinusReflectivity; // albedo * 漫反射比例
}

// Unity Blend
half3 BlendNormals(half3 n1, half3 n2)
{
    return normalize(half3(n1.xy + n2.xy, n1.z*n2.z));
    // return normalize(half3(n1.xy + n2.xy, n1.z)); // UDN
}

half3 UnpackScaleNormalRGorAG(half4 packednormal, half bumpScale)
{
    #if defined(UNITY_NO_DXT5nm)
        half3 normal = packednormal.xyz * 2 - 1;
        #if (SHADER_TARGET >= 30)
            // SM2.0: instruction count limitation
            // SM2.0: normal scaler is not supported
            normal.xy *= bumpScale;
        #endif
        return normal;
    #else
        // This do the trick
        packednormal.x *= packednormal.w;
        half3 normal;
        normal.xy = (packednormal.xy * 2 - 1);
        #if (SHADER_TARGET >= 30)
            // SM2.0: instruction count limitation
            // SM2.0: normal scaler is not supported
            normal.xy *= bumpScale;
        #endif
        normal.z = sqrt(1.0 - saturate(dot(normal.xy, normal.xy)));
        return normal;
    #endif
}

half3 UnpackScaleNormal(half4 packednormal, half bumpScale)
{
    return UnpackScaleNormalRGorAG(packednormal, bumpScale);
}

half3 UDNBlendNormal(half3 n1,half3 n2, half mask)
{
	return lerp(n1, BlendNormals(n1, n2), mask);
}

half BlendValue(half a, half b, half t)
{
	return lerp(a,b,t);
}

half3 UDNBlendNormal(half3 n1,half3 n2)
{
	return BlendNormals(n1, n2);
}
// 法线混合+遮罩 zzz
half3 BlendNormalTS(half3 normalTangent, half3 detailNormalTangent, half mask){

    //#if _DETAIL_LERP
    //    normalTangent = lerp(
    //        normalTangent,
    //        detailNormalTangent,
    //        mask);
    //#else
        // normalTangent = lerp(
        //     normalTangent,
        //     BlendNormals(normalTangent, detailNormalTangent),
        //     mask);
    //#endif	
		// mask = lerp(1,0,step(mask,0));
        // normalTangent = lerp(normalTangent,BlendNormals(normalTangent, detailNormalTangent),mask); // 混合
		
		normalTangent = lerp(normalTangent,detailNormalTangent,mask); // 覆盖
    //#endif
	return normalTangent;
}

// 妆容混合颜色, 应该不能直接覆盖
half4 BlendColor_Layer(half4 srcCol, half4 outCol) {

	// #if _Layer2_Blend_Normal
		// outCol.rgb = srcCol.rgb * srcCol.a + outCol.rgb * (1 - srcCol.a);
	// #elif _Layer2_Blend_Multiply
		outCol.rgb = lerp(outCol.rgb, srcCol.rgb, srcCol.a);		
	// #endif

	outCol.a = saturate(outCol.a + srcCol.a);
	return outCol;
}
// 这里设置worldNormal的值
inline FragmentCommonData MetallicSetup_FunDream (half4 i_tex, half4 detailUV, float4 tangentToWorld[3], half4 outCol)
{
	half2 uv = i_tex.xy;    
    // half2 metallicGloss =  0; // MetallicGloss_FunDream(uv); 获取当前metallicGloss
    // half metallic = metallicGloss.x;
    // half smoothness = metallicGloss.y; // this is 1 minus the square root of half roughness m.
    half oneMinusReflectivity;
    half3 specColor;

	// half4 mainTexCol = SAMPLE_TEXTURE2D_Default (_MainTexT, i_tex.xy);

    // TangentSpace Normal	
	#if _NORMALMAP
		// outNormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_NormalMap, i_tex.xy), _NormalMapScale);
		// outNormalTS = SampleNormalMap(i_tex.xy,, TEXTURE2D_ARGS(_BumpMap, sampler_BumpMap), _NormalMapScale);
		half3 outNormalTS = SampleNormalMap(i_tex.xy, TEXTURE2D_ARGS(_BumpMap, sampler_BumpMap));
	#else
		half3 outNormalTS = half3(0, 0, 1); 
	#endif

	// half4 outCol = mainTexCol * _Color;
	// half4 outCol = mainTexCol;
	half outMetallic = 0; // 默认金属度
	half outSmoothness = 0;

	// init layer common values
	
    // Layer UV Offsets
		#if _LAYER_0_NORMAL
			half2 layer0SourceUV = GetLayer0Texcoord(i_tex, detailUV);
			half2 layer0UV = layer0SourceUV * _Layer0Normal_ST.xy + _Layer0Normal_ST.zw;				
		#endif
		#if _LAYER_1_TEX 
			half2 layer1SourceUV = GetLayer1Texcoord(i_tex, detailUV);
			half2 layer1UV = layer1SourceUV * _Layer1Tex_ST.xy + _Layer1Tex_ST.zw;		
			half layer1Mask = GetLayer1Mask(layer1UV);	
		#endif

		#if (_LAYER_2_TEX || _LAYER_2_NORMAL)
			half2 layer2SourceUV = GetLayer2Texcoord(i_tex, detailUV);
			half2 layer2UV = layer2SourceUV * _Layer2Tex_ST.xy + _Layer2Tex_ST.zw;		
			half layer2Mask = GetLayer2Mask(layer2UV);	
		#endif

		#if (_LAYER_3_TEX || _LAYER_3_NORMAL)
			half2 layer3SourceUV = GetLayer3Texcoord(i_tex, detailUV);
			half2 layer3UV = layer3SourceUV * _Layer3Tex_ST.xy + _Layer3Tex_ST.zw;		
			half layer3Mask = GetLayer3Mask(layer3UV);	
		#endif

		#if (_LAYER_4_TEX || _LAYER_4_NORMAL)
			half2 layer4SourceUV = GetLayer4Texcoord(i_tex, detailUV);
			half2 layer4UV = layer4SourceUV * _Layer4Tex_ST.xy + _Layer4Tex_ST.zw;		
			half layer4Mask = GetLayer4Mask(layer4UV);	
		#endif

		#if (_LAYER_5_TEX || _LAYER_5_NORMAL)
			half2 layer5SourceUV = GetLayer5Texcoord(i_tex, detailUV);
			half2 layer5UV = layer5SourceUV * _Layer5Tex_ST.xy + _Layer5Tex_ST.zw;		
			half layer5Mask = GetLayer5Mask(layer5UV);	
		#endif

		#if (_LAYER_6_TEX || _LAYER_6_NORMAL)
			half2 layer6SourceUV = GetLayer6Texcoord(i_tex, detailUV);
			half2 layer6UV = layer6SourceUV * _Layer6Tex_ST.xy + _Layer6Tex_ST.zw;		
			half layer6Mask = GetLayer6Mask(layer6UV);	
		#endif

		#if (_LAYER_7_TEX || _LAYER_7_NORMAL)
			half2 layer7SourceUV = GetLayer7Texcoord(i_tex, detailUV);
			half2 layer7UV = layer7SourceUV * _Layer7Tex_ST.xy + _Layer7Tex_ST.zw;		
			half layer7Mask = GetLayer7Mask(layer7UV);	
		#endif
	// ------- UV -----



	// ------ Layer ---- calulate layer color metallic smoothness and alpha	
		#if _LAYER_1_TEX 
			half4 layer1TexCol = SAMPLE_TEXTURE2D_Default (_Layer1Tex, layer1UV);		
			layer1TexCol = layer1TexCol*_Layer1Color*layer1Mask; 
			// outCol.rgb = lerp(outCol.rgb, layer1TexCol* outCol.rgb,layer1TexCol.a); // 重叠部分进行一次混合	
			outCol.rgb = lerp(outCol.rgb, layer1TexCol,layer1TexCol.a); // 重叠部分进行一次混合		
			#if _LAYER_1_MASK 
				half _layer1Mask = SAMPLE_TEXTURE2D_Default (_Layer1Mask, layer1UV);
				// _layer1Mask = step(0,1,_layer1Mask.r);
				_layer1Mask = lerp(1,0,step(_layer1Mask,0));
				layer1TexCol.a *=layer1Mask* _layer1Mask;
			#endif

			outMetallic +=  _Layer1Metallic * layer1TexCol.a; // 区域金属度进行叠加
			outSmoothness += _Layer1Smoothness * layer1TexCol.a; // 区域粗糙度度进行叠加

			// half3 fixedMetallicDiffuse = outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic);
			outCol.rgb = lerp(outCol.rgb,outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic), layer1TexCol.a);
		#endif
		#if _LAYER_2_TEX 
			half4 layer2TexCol = SAMPLE_TEXTURE2D_Default (_Layer2Tex, layer2UV);

			layer2TexCol = lerp(0, layer2TexCol, layer2Mask);
			outCol = BlendColor_Layer(layer2TexCol * _Layer2Color, outCol);
				// outCol.rgb = lerp(outCol.rgb, layer1TexCol,layer1TexCol.a);
			#if _LAYER_2_MASK 
				layer2Mask = SAMPLE_TEXTURE2D_Default (_Layer2Mask, layer2UV);	
					layer2TexCol.a *= layer2Mask.r;	
			#endif
			outMetallic +=  _Layer2Metallic * layer2TexCol.a;
			outSmoothness += _Layer2Smoothness * layer2TexCol.a;

			// half3 fixedMetallicDiffuse = outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic);
			outCol.rgb = lerp(outCol.rgb,outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic), layer2TexCol.a);
		#endif

		#if _LAYER_3_TEX 
			half4 layer3TexCol = SAMPLE_TEXTURE2D_Default (_Layer3Tex, layer3UV);
			layer3TexCol = lerp(0, layer3TexCol, layer3Mask);
			outCol = BlendColor_Layer(layer3TexCol * _Layer3Color, outCol);			
			#if _LAYER_3_MASK 
				layer3Mask = SAMPLE_TEXTURE2D_Default (_Layer3Mask, layer3UV);	
				layer3TexCol.a *= layer3Mask.r;	
			#endif
			outMetallic +=  _Layer3Metallic * layer3TexCol.a;
			outSmoothness += _Layer3Smoothness * layer3TexCol.a;		
			outCol.rgb = lerp(outCol.rgb,outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic), layer3TexCol.a);
		#endif

		#if _LAYER_4_TEX 
			half4 layer4TexCol = SAMPLE_TEXTURE2D_Default (_Layer4Tex, layer4UV);
			layer4TexCol = lerp(0, layer4TexCol, layer4Mask);
			outCol = BlendColor_Layer(layer4TexCol * _Layer4Color, outCol);			
			#if _LAYER_4_MASK 
				layer4Mask = SAMPLE_TEXTURE2D_Default (_Layer4Mask, layer4UV);	
				layer4TexCol.a *= layer4Mask.r;	
			#endif
			outMetallic +=  _Layer4Metallic * layer4TexCol.a;
			outSmoothness += _Layer4Smoothness * layer4TexCol.a;		
			outCol.rgb = lerp(outCol.rgb,outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic), layer4TexCol.a);
		#endif

		#if _LAYER_5_TEX 
			half4 layer5TexCol = SAMPLE_TEXTURE2D_Default (_Layer5Tex, layer5UV);
			layer5TexCol = lerp(0, layer5TexCol, layer5Mask);
			outCol = BlendColor_Layer(layer5TexCol * _Layer5Color, outCol);			
			#if _LAYER_5_MASK 
				layer5Mask = SAMPLE_TEXTURE2D_Default (_Layer5Mask, layer5UV);	
				layer5TexCol.a *= layer5Mask.r;	
			#endif
			outMetallic +=  _Layer5Metallic * layer5TexCol.a;
			outSmoothness += _Layer5Smoothness * layer5TexCol.a;		
			outCol.rgb = lerp(outCol.rgb,outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic), layer5TexCol.a);
		#endif


		#if _LAYER_6_TEX 
			half4 layer6TexCol = SAMPLE_TEXTURE2D_Default (_Layer6Tex, layer6UV);
			layer6TexCol = lerp(0, layer6TexCol, layer6Mask);
			outCol = BlendColor_Layer(layer6TexCol * _Layer6Color, outCol);			
			#if _LAYER_6_MASK 
				layer6Mask = SAMPLE_TEXTURE2D_Default (_Layer6Mask, layer6UV);	
				layer6TexCol.a *= layer6Mask.r;	
			#endif
			outMetallic +=  _Layer6Metallic * layer6TexCol.a;
			outSmoothness += _Layer6Smoothness * layer6TexCol.a;		
			outCol.rgb = lerp(outCol.rgb,outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic), layer6TexCol.a);
		#endif


		#if _LAYER_7_TEX 
			half4 layer7TexCol = SAMPLE_TEXTURE2D_Default (_Layer7Tex, layer7UV);
			layer7TexCol = lerp(0, layer7TexCol, layer7Mask);
			outCol = BlendColor_Layer(layer7TexCol * _Layer7Color, outCol);			
			#if _LAYER_7_MASK 
				layer7Mask = SAMPLE_TEXTURE2D_Default (_Layer7Mask, layer7UV);	
				layer7TexCol.a *= layer7Mask.r;	
			#endif
			outMetallic +=  _Layer7Metallic * layer7TexCol.a;
			outSmoothness += _Layer7Smoothness * layer7TexCol.a;		
			outCol.rgb = lerp(outCol.rgb,outCol.rgb * OneMinusReflectivityFromMetallic(outMetallic), layer7TexCol.a);
		#endif
	// ------ Layer ----
		
	#if _LAYER_0_NORMAL		
		half3 layer0NormalTS = SampleNormalMap(layer0UV, TEXTURE2D_ARGS(_Layer0Normal, sampler_Layer0Normal), _Layer0NormalScale);		
		outNormalTS = BlendNormals(outNormalTS, layer0NormalTS); 
	#endif
	#if (_LAYER_1_TEX && _LAYER_1_NORMAL)
		// half3 layer1NormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_Layer1Normal, layer1UV), _Layer1NormalScale);	
		half3 layer1NormalTS = SampleNormalMap(layer1UV, TEXTURE2D_ARGS(_Layer1Normal, sampler_Layer1Normal), _Layer1NormalScale);	
		#if _Layer1Norma1Mode_1
			outNormalTS = UDNBlendNormal(outNormalTS, layer1NormalTS, layer1Mask)
		#else
			outNormalTS = BlendNormalTS(outNormalTS, layer1NormalTS, layer1Mask);
		#endif
	#endif

	#if _LAYER_2_NORMAL
		// half3 layer2NormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_Layer2Normal, layer2UV), _Layer2NormalScale);
		half3 layer2NormalTS = SampleNormalMap(layer2UV ,TEXTURE2D_ARGS(_Layer2Normal, sampler_Layer2Normal), _Layer2NormalScale);	
		outNormalTS = BlendNormalTS(outNormalTS, layer2NormalTS, layer2Mask);
	#endif

	#if _LAYER_3_NORMAL
		// half3 layer3NormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_Layer3Normal, layer3UV), _Layer3NormalScale);
		half3 layer3NormalTS = SampleNormalMap(layer3UV ,TEXTURE2D_ARGS(_Layer3Normal, sampler_Layer3Normal), _Layer3NormalScale);	
		outNormalTS = BlendNormalTS(outNormalTS, layer3NormalTS, layer3Mask);
	#endif

	#if _LAYER_4_NORMAL
		// half3 layer4NormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_Layer4Normal, layer4UV), _Layer4NormalScale);
		half3 layer4NormalTS = SampleNormalMap(layer4UV, TEXTURE2D_ARGS(_Layer4Normal, sampler_Layer4Normal), _Layer4NormalScale);	
		outNormalTS = BlendNormalTS(outNormalTS, layer4NormalTS, layer4Mask);
	#endif

	#if _LAYER_5_NORMAL
		// half3 layer5NormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_Layer5Normal, layer5UV), _Layer5NormalScale);
		half3 layer5NormalTS = SampleNormalMap(layer5UV, TEXTURE2D_ARGS(_Layer5Normal, sampler_Layer5Normal), _Layer5NormalScale);	
		outNormalTS = BlendNormalTS(outNormalTS, layer5NormalTS, layer5Mask);
	#endif

	#if _LAYER_6_NORMAL
		// half3 layer6NormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_Layer6Normal, layer6UV), _Layer6NormalScale);
		half3 layer6NormalTS = SampleNormalMap(layer6UV, TEXTURE2D_ARGS(_Layer6Normal, sampler_Layer6Normal), _Layer6NormalScale);	
		// layer6NormalTS = half3(0,0,1);
		outNormalTS = BlendNormalTS(outNormalTS, layer6NormalTS, layer6Mask);
	#endif

	#if _LAYER_7_NORMAL
		// half3 layer7NormalTS = UnpackScaleNormal(SAMPLE_TEXTURE2D_Default (_Layer7Normal, layer7UV), _Layer7NormalScale);
		half3 layer7NormalTS = SampleNormalMap(layer7UV, TEXTURE2D_ARGS(_Layer7Normal, sampler_Layer7Normal), _Layer7NormalScale);	
		// layer7NormalTS = half3(0,0,1);
		outNormalTS = BlendNormalTS(outNormalTS, layer7NormalTS, layer7Mask);
	#endif
	
	// final output
	FragmentCommonData o = (FragmentCommonData)0;

	// half3 diff = outCol.rgb;
	// diff = DiffuseAndSpecularFromMetallic (outCol.rgb, saturate(outMetallic), /*out*/ o.specColor, /*out*/ oneMinusReflectivity);	
	// #if _NORMALMAP
		half3 tangent = tangentToWorld[0].xyz;
		half3 binormal = tangentToWorld[1].xyz;
		half3 normal = tangentToWorld[2].xyz;        
		// float3 normalWorld = NormalizePerPixelNormal(tangent * outNormalTS.x + binormal * outNormalTS.y + normal * outNormalTS.z); 
		float3 normalWorld = normalize((float3)(tangent * outNormalTS.x + binormal * outNormalTS.y + normal * outNormalTS.z));     
		
		    
	// #else
	// 	float3 normalWorld = normalize(tangentToWorld[2].xyz);
	// #endif 

    
	
    o.diffColor = outCol.rgb;
    // o.specColor = specColor;
    // o.oneMinusReflectivity = saturate(oneMinusReflectivity);
    o.smoothness = saturate(outSmoothness);
	o.normalWorld = normalWorld;	

    return o;
}


#endif