// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CustomURP/URP_EyeShader_ASE"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[ASEBegin][NoScaleOffset][Header(Main Textures)]_RGBMask("RGBMask", 2D) = "white" {}
		[NoScaleOffset]_IrisExtraDetail("IrisExtraDetail", 2D) = "white" {}
		[NoScaleOffset]_Sclera_Normal("Sclera_Normal", 2D) = "bump" {}
		[NoScaleOffset]_Lens_Base_Normal("Lens_Base_Normal", 2D) = "bump" {}
		[Header(Color Customization)][Space(6)]_EyeBallColorGlossA("[眼白颜色]EyeBallColor-Gloss(A)", Color) = (1,1,1,0.853)
		_IrisBaseColor("[虹膜颜色]IrisBaseColor", Color) = (0.4999702,0.5441177,0.4641004,1)
		_IrisExtraColorAmountA("[虹膜遮罩颜色]IrisExtraColor-Amount(A)", Color) = (0.08088237,0.07573904,0.04698314,0.591)
		_EyeVeinColorAmountA("[血管颜色]EyeVeinColor-Amount(A)", Color) = (0.375,0,0,0)
		_RingColorAmount("[虹膜边缘]_RingColorAmount", Color) = (0,0,0,0)
		_LimbalEdge_Adjustment("LimbalEdge_Adjustment", Range( 0 , 1)) = 0
		_LimbalRingGloss("LimbalRingGloss", Range( 0 , 1)) = 0
		_ScleraBumpScale("ScleraBumpScale", Range( 0 , 1)) = 0
		_EyeSize("[虹膜放大]EyeSize", Range( 0 , 2)) = 1
		_BIrisSize("[虹膜纹理放大]IrisSize", Range( 0 , 10)) = 1
		_LensGloss("[高光点放大]LensGloss", Range( 0 , 1)) = 0.98
		_LensPush("[高光点推进]LensPush", Range( 0 , 1)) = 0.64
		_EyeReflectCubeMap("[反射高光]EyeReflectCubeMap", CUBE) = "white" {}
		_EyeReflectFactor("[高光系数]EyeReflectFactor", Range( 0 , 2)) = 0
		_Rotate_Y("[旋转高光]Rotate_Y", Range( -360 , 360)) = 0
		_RotateXYZ("[旋转高光]RotateXYZ", Range( -360 , 360)) = 0
		_XYZ_Axis("XYZ_Axis", Vector) = (0,0,0,0)
		_FullEyeFactor("[眼球整体放大]FullEyeFactor", Range( -1 , 1)) = 0
		[Header(Metalness)]_LimbalRingMetalness("LimbalRingMetalness", Range( 0 , 1)) = 0
		_IrisPupilMetalness("IrisPupilMetalness", Range( 0 , 1)) = 0
		_EyeBallMetalness("EyeBallMetalness", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Caustic FX)]_CausticMask("CausticMask", 2D) = "white" {}
		_CausticPower("CausticPower", Range( 0.5 , 10)) = 17
		_CausticFX_inDarkness("CausticFX_inDarkness", Range( 0 , 2)) = 17
		[Header(Pupil Control)][Space(6)]_PupilColorEmissivenessA("[瞳孔颜色]PupilColor-Emissiveness(A)", Color) = (0,0,0,0)
		_PupilHeight1Width1("[瞳孔形状]Pupil", Range( 0.01 , 10)) = 1
		_PupilSharpness("[瞳孔模糊]PupilSharpness", Range( 0.1 , 5)) = 5
		_PupilAutoDilateFactor("[瞳孔大小]PupilAutoDilateFactor", Range( 0 , 50)) = 0
		_PupilSize("[瞳孔大小]PupilSize", Range( 0.001 , 90)) = 70
		[NoScaleOffset][Header(Parallax Control)]_ParallaxMask("ParallaxMask", 2D) = "black" {}
		_PushParallaxMask("PushParallaxMask", Range( 0 , 5)) = 1
		_PupilParallaxHeight("PupilParallaxHeight", Range( 0 , 3)) = 2.5
		_EyeShadingPower("EyeShadingPower", Range( 0.01 , 2)) = 0.5
		_MinimumGlow("MinimumGlow", Range( 0 , 1)) = 0.2
		_Eyeball_microScatter("Eyeball_microScatter", Range( 0 , 5)) = 0
		[ASEEnd]_SubSurfaceFromDirectionalLight("SubSurfaceFromDirectionalLight", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		Cull Back
		AlphaToMask Off
		HLSLINCLUDE
		#pragma target 2.0
		#define UNITY_PI 3.1415926

		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile _ _SHADOWS_SOFT
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
			    #define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			//#include "UnityCG.cginc"
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#pragma multi_compile_instancing


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord : TEXCOORD0;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _IrisBaseColor;
			float4 _IrisExtraColorAmountA;
			float4 _RingColorAmount;
			float4 _EyeVeinColorAmountA;
			float4 _EyeBallColorGlossA;
			float4 _PupilColorEmissivenessA;
			float3 _XYZ_Axis;
			float _EyeReflectFactor;
			float _LensPush;
			float _CausticFX_inDarkness;
			float _Rotate_Y;
			float _LimbalRingMetalness;
			float _EyeBallMetalness;
			float _CausticPower;
			float _IrisPupilMetalness;
			float _RotateXYZ;
			float _ScleraBumpScale;
			float _EyeShadingPower;
			float _SubSurfaceFromDirectionalLight;
			float _LimbalRingGloss;
			float _BIrisSize;
			float _PupilSharpness;
			float _PupilParallaxHeight;
			float _PushParallaxMask;
			float _PupilHeight1Width1;
			float _PupilAutoDilateFactor;
			float _LimbalEdge_Adjustment;
			float _EyeSize;
			float _FullEyeFactor;
			half _PupilSize;
			float _Eyeball_microScatter;
			float _LensGloss;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _RGBMask;
			sampler2D _ParallaxMask;
			sampler2D _IrisExtraDetail;
			sampler2D _Sclera_Normal;
			sampler2D _Lens_Base_Normal;
			sampler2D _CausticMask;
			samplerCUBE _EyeReflectCubeMap;
			UNITY_INSTANCING_BUFFER_START(CustomEyeShadersEyeShader_ASE)
				UNITY_DEFINE_INSTANCED_PROP(float, _MinimumGlow)
			UNITY_INSTANCING_BUFFER_END(CustomEyeShadersEyeShader_ASE)


			inline float2 ParallaxOffset( half h, half height, half3 viewDir )
			{
				h = h * height - height/2.0;
				float3 v = normalize( viewDir );
				v.z += 0.42;
				return h* (v.xy / v.z);
			}
			
			float3 RotateYDegrees918( float3 normal, float degrees )
			{
				float alpha = degrees * UNITY_PI / 180.0;
				float sina, cosa;
								sincos(alpha, sina, cosa);
								float2x2 m = float2x2(cosa, -sina, sina, cosa);
				return float3(mul(m, normal.xz), normal.y).xzy;
			}
			
			float3 RotationMatrix923( float3 vAxis, float fAngle, float3 uvw )
			{
				// compute sin/cos of fAngle
				fAngle *= UNITY_PI / 180.0;
				float2 vSinCos;
				#ifdef OPENGL
					vSinCos.x = sin(fAngle);
					vSinCos.y = cos(fAngle);
				#else
					sincos(fAngle, vSinCos.x, vSinCos.y);
				#endif
				const float c = vSinCos.y;
				const float s = vSinCos.x;
				const float t = 1.0 - c;
				const float x = vAxis.x;
				const float y = vAxis.y;
				const float z = vAxis.z;
				float3x3 RotateMatrix = float3x3(t * x * x + c,      t * x * y - s * z,  t * x * z + s * y,
								t * x * y + s * z,  t * y * y + c,      t * y * z - s * x,
								t * x * z - s * y,  t * y * z + s * x,  t * z * z + c);
				return mul(RotateMatrix,uvw);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord7.xyz = v.texcoord.xyz;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord;
					o.lightmapUVOrVertexSH.xy = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				
				o.clipPos = positionCS;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				o.screenPos = ComputeScreenPos(positionCS);
				#endif
				return o;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif
				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif
	
				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 texCoord858 = IN.ase_texcoord7.xyz.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_861_0 = ( ( 1.0 - texCoord858.y ) * texCoord858.y );
				#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
				float3 ase_worldlightDir = 0;
				#else //aseld
				float3 ase_worldlightDir = ( _MainLightPosition.xyz);
				#endif //aseld
				float3 _Vector1 = float3(0.15,0.06,0.4);
				float fresnelNdotV866 = dot( WorldNormal, ase_worldlightDir );
				float fresnelNode866 = ( _Vector1.x + _Vector1.y * pow( 1.0 - fresnelNdotV866, _Vector1.z ) );
				float3 temp_cast_0 = (( pow( ( temp_output_861_0 + temp_output_861_0 + temp_output_861_0 + temp_output_861_0 ) , ( 25.0 * _EyeShadingPower ) ) * fresnelNode866 )).xxx;
				float temp_output_2_0_g43 = _EyeShadingPower;
				float temp_output_3_0_g43 = ( 1.0 - temp_output_2_0_g43 );
				float3 appendResult7_g43 = (float3(temp_output_3_0_g43 , temp_output_3_0_g43 , temp_output_3_0_g43));
				float3 eyeShading672 = ( ( temp_cast_0 * temp_output_2_0_g43 ) + appendResult7_g43 );
				float3 break690 = _MainLightColor.rgb;
				half FullEyeFactor878 = _FullEyeFactor;
				float temp_output_899_0 = ( ( 1.0 - FullEyeFactor878 ) * ( (float)2 - _EyeSize ) );
				float2 temp_cast_3 = (temp_output_899_0).xx;
				float2 temp_cast_5 = (( ( 1.0 - temp_output_899_0 ) / 2.0 )).xx;
				float2 texCoord264 = IN.ase_texcoord7.xyz.xy * temp_cast_3 + temp_cast_5;
				float2 eyeSizeUVs604 = texCoord264;
				float4 tex2DNode166 = tex2D( _RGBMask, eyeSizeUVs604 );
				float lerpResult706 = lerp( tex2DNode166.b , ( tex2DNode166.b - tex2DNode166.r ) , _LimbalEdge_Adjustment);
				float clampResult721 = clamp( lerpResult706 , 0.0 , 1.0 );
				float IrisPupil_MASK585 = clampResult721;
				float clampResult545 = clamp( ( _PupilSize + ( ( ( ( ( break690.x + break690.y + break690.z ) / 3.0 ) * 0.0 ) * IrisPupil_MASK585 ) * ( _PupilAutoDilateFactor + ( _PupilAutoDilateFactor * FullEyeFactor878 ) ) ) ) , 0.0 , 99.0 );
				float temp_output_151_0 = ( 100.0 - ( 100.0 - clampResult545 ) );
				float2 appendResult149 = (float2(( temp_output_151_0 / 2.0 ) , ( temp_output_151_0 / ( _PupilHeight1Width1 * 2.0 ) )));
				float4 appendResult152 = (float4(temp_output_151_0 , ( temp_output_151_0 / _PupilHeight1Width1 ) , 0.0 , 0.0));
				float2 uv_ParallaxMask416 = IN.ase_texcoord7.xyz.xy;
				float4 tex2DNode416 = tex2D( _ParallaxMask, uv_ParallaxMask416 );
				float4 lerpResult418 = lerp( float4( 0,0,0,0 ) , tex2DNode416 , _PushParallaxMask);
				float PupilParallaxHeight574 = _PupilParallaxHeight;
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 ase_tanViewDir =  tanToWorld0 * WorldViewDirection.x + tanToWorld1 * WorldViewDirection.y  + tanToWorld2 * WorldViewDirection.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 paralaxOffset255 = ParallaxOffset( lerpResult418.r , PupilParallaxHeight574 , ase_tanViewDir );
				float2 ParallaxPush_Vec2580 = paralaxOffset255;
				float2 texCoord147 = IN.ase_texcoord7.xyz.xy * appendResult152.xy + ParallaxPush_Vec2580;
				float clampResult122 = clamp( ( pow( distance( appendResult149 , texCoord147 ) , ( _PupilSharpness * 7.0 ) ) + ( 1.0 - IrisPupil_MASK585 ) ) , 0.0 , 1.0 );
				float PupilMaskArea625 = clampResult122;
				float Sclera_MASK591 = tex2DNode166.g;
				float clampResult719 = clamp( ( ( _EyeVeinColorAmountA.a * 1.5 ) * Sclera_MASK591 ) , 0.0 , 1.0 );
				float4 lerpResult177 = lerp( ( _EyeBallColorGlossA * ( 1.0 - IrisPupil_MASK585 ) ) , ( _EyeVeinColorAmountA * Sclera_MASK591 ) , clampResult719);
				float4 LimbalRing_Color619 = _RingColorAmount;
				float LimbalRing_MASK590 = tex2DNode166.r;
				float eyeLimbalRingPower612 = ( _RingColorAmount.a * LimbalRing_MASK590 );
				float4 lerpResult184 = lerp( lerpResult177 , LimbalRing_Color619 , eyeLimbalRingPower612);
				float IrisPupilFactor577 = ( temp_output_151_0 * 0.017 );
				float eyeSizing616 = ( ( ( (float)10 - _BIrisSize ) * temp_output_899_0 ) + temp_output_899_0 + IrisPupilFactor577 );
				float2 temp_cast_11 = (eyeSizing616).xx;
				float2 texCoord190 = IN.ase_texcoord7.xyz.xy * temp_cast_11 + ( ( ParallaxPush_Vec2580 * float2( 0.15,0.15 ) ) + ( ( 1.0 - eyeSizing616 ) / 2.0 ) );
				float4 BaseIrisColors809 = ( ( ( ( tex2D( _IrisExtraDetail, texCoord190 ) * _IrisExtraColorAmountA ) * _IrisExtraColorAmountA.a ) * IrisPupil_MASK585 ) + ( IrisPupil_MASK585 * _IrisBaseColor ) );
				float4 temp_output_326_0 = ( PupilMaskArea625 * ( ( lerpResult184 * lerpResult184 ) + BaseIrisColors809 ) );
				float _MinimumGlow_Instance = UNITY_ACCESS_INSTANCED_PROP(CustomEyeShadersEyeShader_ASE,_MinimumGlow);
				float clampResult478 = clamp( ( 0.0 * PupilMaskArea625 ) , _MinimumGlow_Instance , 1.0 );
				float4 lerpResult568 = lerp( ( temp_output_326_0 * ( clampResult478 * 0.0 ) ) , float4( 0,0,0,0 ) , eyeLimbalRingPower612);
				float4 temp_output_674_0 = ( float4( eyeShading672 , 0.0 ) * lerpResult568 );
				float fresnelNdotV727 = dot( WorldNormal, SafeNormalize(_MainLightPosition.xyz) );
				float fresnelNode727 = ( 0.5 + 1.0 * pow( 1.0 - fresnelNdotV727, 1.0 ) );
				float FresnelLight732 = ( 1.0 - fresnelNode727 );
				float4 SubSurfaceArea784 = lerpResult177;
				float4 clampResult794 = clamp( ( FresnelLight732 * SubSurfaceArea784 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				float dotResult782 = dot( SafeNormalize(_MainLightPosition.xyz) , WorldNormal );
				float LightComponent779 = dotResult782;
				float4 clampResult795 = clamp( ( LightComponent779 * SubSurfaceArea784 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				float4 lerpResult787 = lerp( temp_output_674_0 , ( _MainLightColor * ( clampResult794 + clampResult795 + temp_output_674_0 ) ) , _SubSurfaceFromDirectionalLight);
				
				float4 appendResult572 = (float4(0.0 , 0.0 , 1.0 , 0.0));
				float clampResult717 = clamp( ( ( 1.0 - IrisPupil_MASK585 ) * 0.1 ) , 0.0 , 1.0 );
				float4 temp_output_504_0 = ( appendResult572 * clampResult717 * _Eyeball_microScatter );
				float4 lerpResult502 = lerp( float4( float3(0,0,1) , 0.0 ) , appendResult572 , temp_output_504_0);
				float3 unpack331 = UnpackNormalScale( tex2D( _Sclera_Normal, eyeSizeUVs604 ), _ScleraBumpScale );
				unpack331.z = lerp( 1, unpack331.z, saturate(_ScleraBumpScale) );
				float3 lerpResult139 = lerp( float3(0,0,1) , UnpackNormalScale( tex2D( _Lens_Base_Normal, eyeSizeUVs604 ), 1.0f ) , _LensPush);
				float3 lerpResult569 = lerp( BlendNormal( lerpResult502.xyz , unpack331 ) , lerpResult139 , IrisPupil_MASK585);
				float3 NORMAL_OUTPUT640 = lerpResult569;
				
				float2 paralaxOffset411 = ParallaxOffset( tex2DNode416.r , ( PupilParallaxHeight574 * 0.03 ) , ase_tanViewDir );
				float2 texCoord409 = IN.ase_texcoord7.xyz.xy * float2( 0,0 ) + paralaxOffset411;
				float2 ParallaxOffset_Vec2583 = texCoord409;
				float2 eyeLocalUV633 = ( eyeSizeUVs604 + ParallaxOffset_Vec2583 );
				float cos373 = cos( SafeNormalize(_MainLightPosition.xyz).x );
				float sin373 = sin( SafeNormalize(_MainLightPosition.xyz).x );
				float2 rotator373 = mul( eyeLocalUV633 - float2( 0.5,0.5 ) , float2x2( cos373 , -sin373 , sin373 , cos373 )) + float2( 0.5,0.5 );
				float4 tex2DNode370 = tex2D( _CausticMask, rotator373 );
				float clampResult856 = clamp( ( ( FresnelLight732 + 0.5 ) * 1.25 ) , 0.0 , 1.0 );
				float4 lerpResult761 = lerp( ( BaseIrisColors809 + ( BaseIrisColors809 * tex2DNode370 * ( _CausticPower * clampResult856 ) ) ) , ( BaseIrisColors809 + ( BaseIrisColors809 * tex2DNode370 * _CausticPower ) ) , _CausticFX_inDarkness);
				float4 clampResult745 = clamp( lerpResult761 , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
				float4 caustEmissission827 = clampResult745;
				float causticInDark824 = _CausticFX_inDarkness;
				float4 BaseColoring814 = ( PupilMaskArea625 * _MinimumGlow_Instance * temp_output_326_0 );
				float4 clampResult521 = clamp( ( lerpResult568 + lerpResult568 + ( BaseColoring814 + ( clampResult745 * PupilMaskArea625 ) ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				float temp_output_665_0 = ( _PupilColorEmissivenessA.a * ( 1.0 - PupilMaskArea625 ) );
				float4 lerpResult648 = lerp( clampResult521 , lerpResult568 , temp_output_665_0);
				float4 PreEmissive804 = lerpResult648;
				float4 PupilGlow833 = ( _PupilColorEmissivenessA * temp_output_665_0 );
				float3 vAxis923 = _XYZ_Axis;
				float fAngle923 = _RotateXYZ;
				float3 tanNormal914 = lerpResult569;
				float3 worldNormal914 = float3(dot(tanToWorld0,tanNormal914), dot(tanToWorld1,tanNormal914), dot(tanToWorld2,tanNormal914));
				float3 normal918 = reflect( -WorldViewDirection , worldNormal914 );
				float degrees918 = _Rotate_Y;
				float3 localRotateYDegrees918 = RotateYDegrees918( normal918 , degrees918 );
				float3 uvw923 = localRotateYDegrees918;
				float3 localRotationMatrix923 = RotationMatrix923( vAxis923 , fAngle923 , uvw923 );
				
				float clampResult661 = clamp( ( ( LimbalRing_MASK590 * _LimbalRingMetalness ) + ( _EyeBallMetalness * ( 1.0 - IrisPupil_MASK585 ) ) + ( IrisPupil_MASK585 * _IrisPupilMetalness ) ) , 0.0 , 1.0 );
				float METALNESS_OUTPUT663 = clampResult661;
				
				float EyeBallGloss622 = _EyeBallColorGlossA.a;
				float lerpResult135 = lerp( EyeBallGloss622 , ( _LensGloss * IrisPupil_MASK585 ) , IrisPupil_MASK585);
				float4 microScatter608 = temp_output_504_0;
				float lerpResult525 = lerp( ( ( _LimbalRingGloss * LimbalRing_MASK590 ) + lerpResult135 ) , 0.0 , ( ( 1.0 - IrisPupil_MASK585 ) * microScatter608 ).x);
				float SMOOTHNESS_OUTPUT642 = lerpResult525;
				
				float3 Albedo = ( lerpResult787 * _MainLightColor ).rgb;
				float3 Normal = NORMAL_OUTPUT640;
				float3 Emission = ( ( ( ( caustEmissission827 * causticInDark824 ) + ( _MainLightColor * PreEmissive804 ) ) * PupilMaskArea625 ) + PupilGlow833 + ( _EyeReflectFactor * texCUBE( _EyeReflectCubeMap, localRotationMatrix923 ) * IrisPupil_MASK585 ) ).rgb;
				float3 Specular = 0.5;
				float Metallic = METALNESS_OUTPUT663;
				float Smoothness = SMOOTHNESS_OUTPUT642;
				float Occlusion = 1;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
					inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
					inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
					inputData.normalWS = Normal;
					#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif
				half4 color = UniversalFragmentPBR(
					inputData, 
					Albedo, 
					Metallic, 
					Specular, 
					Smoothness, 
					Occlusion, 
					Emission, 
					Alpha);

				#ifdef _TRANSMISSION_ASE
				{
					float shadow = _TransmissionShadow;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
					half3 mainTransmission = max(0 , -dot(inputData.normalWS, mainLight.direction)) * mainAtten * Transmission;
					color.rgb += Albedo * mainTransmission;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 transmission = max(0 , -dot(inputData.normalWS, light.direction)) * atten * Transmission;
							color.rgb += Albedo * transmission;
						}
					#endif
				}
				#endif

				#ifdef _TRANSLUCENCY_ASE
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );

					half3 mainLightDir = mainLight.direction + inputData.normalWS * normal;
					half mainVdotL = pow( saturate( dot( inputData.viewDirectionWS, -mainLightDir ) ), scattering );
					half3 mainTranslucency = mainAtten * ( mainVdotL * direct + inputData.bakedGI * ambient ) * Translucency;
					color.rgb += Albedo * mainTranslucency * strength;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 lightDir = light.direction + inputData.normalWS * normal;
							half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );
							half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;
							color.rgb += Albedo * translucency * strength;
						}
					#endif
				}
				#endif

				#ifdef _REFRACTION_ASE
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, WorldNormal ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif
				
				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _IrisBaseColor;
			float4 _IrisExtraColorAmountA;
			float4 _RingColorAmount;
			float4 _EyeVeinColorAmountA;
			float4 _EyeBallColorGlossA;
			float4 _PupilColorEmissivenessA;
			float3 _XYZ_Axis;
			float _EyeReflectFactor;
			float _LensPush;
			float _CausticFX_inDarkness;
			float _Rotate_Y;
			float _LimbalRingMetalness;
			float _EyeBallMetalness;
			float _CausticPower;
			float _IrisPupilMetalness;
			float _RotateXYZ;
			float _ScleraBumpScale;
			float _EyeShadingPower;
			float _SubSurfaceFromDirectionalLight;
			float _LimbalRingGloss;
			float _BIrisSize;
			float _PupilSharpness;
			float _PupilParallaxHeight;
			float _PushParallaxMask;
			float _PupilHeight1Width1;
			float _PupilAutoDilateFactor;
			float _LimbalEdge_Adjustment;
			float _EyeSize;
			float _FullEyeFactor;
			half _PupilSize;
			float _Eyeball_microScatter;
			float _LensGloss;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			UNITY_INSTANCING_BUFFER_START(CustomEyeShadersEyeShader_ASE)
			UNITY_INSTANCING_BUFFER_END(CustomEyeShadersEyeShader_ASE)


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#define _RECEIVE_SHADOWS_OFF 1
			#pragma multi_compile_instancing
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_SRP_VERSION 70301

			#pragma enable_d3d11_debug_symbols
			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			//#include "UnityCG.cginc"
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma multi_compile_instancing


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _IrisBaseColor;
			float4 _IrisExtraColorAmountA;
			float4 _RingColorAmount;
			float4 _EyeVeinColorAmountA;
			float4 _EyeBallColorGlossA;
			float4 _PupilColorEmissivenessA;
			float3 _XYZ_Axis;
			float _EyeReflectFactor;
			float _LensPush;
			float _CausticFX_inDarkness;
			float _Rotate_Y;
			float _LimbalRingMetalness;
			float _EyeBallMetalness;
			float _CausticPower;
			float _IrisPupilMetalness;
			float _RotateXYZ;
			float _ScleraBumpScale;
			float _EyeShadingPower;
			float _SubSurfaceFromDirectionalLight;
			float _LimbalRingGloss;
			float _BIrisSize;
			float _PupilSharpness;
			float _PupilParallaxHeight;
			float _PushParallaxMask;
			float _PupilHeight1Width1;
			float _PupilAutoDilateFactor;
			float _LimbalEdge_Adjustment;
			float _EyeSize;
			float _FullEyeFactor;
			half _PupilSize;
			float _Eyeball_microScatter;
			float _LensGloss;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _RGBMask;
			sampler2D _ParallaxMask;
			sampler2D _IrisExtraDetail;
			UNITY_INSTANCING_BUFFER_START(CustomEyeShadersEyeShader_ASE)
				UNITY_DEFINE_INSTANCED_PROP(float, _MinimumGlow)
			UNITY_INSTANCING_BUFFER_END(CustomEyeShadersEyeShader_ASE)


			inline float2 ParallaxOffset( half h, half height, half3 viewDir )
			{
				h = h * height - height/2.0;
				float3 v = normalize( viewDir );
				v.z += 0.42;
				return h* (v.xy / v.z);
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord4.xyz = ase_worldTangent;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_tangent = v.ase_tangent;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 texCoord858 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_861_0 = ( ( 1.0 - texCoord858.y ) * texCoord858.y );
				#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
				float3 ase_worldlightDir = 0;
				#else //aseld
				float3 ase_worldlightDir = ( _MainLightPosition.xyz);
				#endif //aseld
				float3 ase_worldNormal = IN.ase_texcoord3.xyz;
				float3 _Vector1 = float3(0.15,0.06,0.4);
				float fresnelNdotV866 = dot( ase_worldNormal, ase_worldlightDir );
				float fresnelNode866 = ( _Vector1.x + _Vector1.y * pow( 1.0 - fresnelNdotV866, _Vector1.z ) );
				float3 temp_cast_0 = (( pow( ( temp_output_861_0 + temp_output_861_0 + temp_output_861_0 + temp_output_861_0 ) , ( 25.0 * _EyeShadingPower ) ) * fresnelNode866 )).xxx;
				float temp_output_2_0_g43 = _EyeShadingPower;
				float temp_output_3_0_g43 = ( 1.0 - temp_output_2_0_g43 );
				float3 appendResult7_g43 = (float3(temp_output_3_0_g43 , temp_output_3_0_g43 , temp_output_3_0_g43));
				float3 eyeShading672 = ( ( temp_cast_0 * temp_output_2_0_g43 ) + appendResult7_g43 );
				float3 break690 = _MainLightColor.rgb;
				half FullEyeFactor878 = _FullEyeFactor;
				float temp_output_899_0 = ( ( 1.0 - FullEyeFactor878 ) * ( (float)2 - _EyeSize ) );
				float2 temp_cast_3 = (temp_output_899_0).xx;
				float2 temp_cast_5 = (( ( 1.0 - temp_output_899_0 ) / 2.0 )).xx;
				float2 texCoord264 = IN.ase_texcoord2.xy * temp_cast_3 + temp_cast_5;
				float2 eyeSizeUVs604 = texCoord264;
				float4 tex2DNode166 = tex2D( _RGBMask, eyeSizeUVs604 );
				float lerpResult706 = lerp( tex2DNode166.b , ( tex2DNode166.b - tex2DNode166.r ) , _LimbalEdge_Adjustment);
				float clampResult721 = clamp( lerpResult706 , 0.0 , 1.0 );
				float IrisPupil_MASK585 = clampResult721;
				float clampResult545 = clamp( ( _PupilSize + ( ( ( ( ( break690.x + break690.y + break690.z ) / 3.0 ) * 0.0 ) * IrisPupil_MASK585 ) * ( _PupilAutoDilateFactor + ( _PupilAutoDilateFactor * FullEyeFactor878 ) ) ) ) , 0.0 , 99.0 );
				float temp_output_151_0 = ( 100.0 - ( 100.0 - clampResult545 ) );
				float2 appendResult149 = (float2(( temp_output_151_0 / 2.0 ) , ( temp_output_151_0 / ( _PupilHeight1Width1 * 2.0 ) )));
				float4 appendResult152 = (float4(temp_output_151_0 , ( temp_output_151_0 / _PupilHeight1Width1 ) , 0.0 , 0.0));
				float2 uv_ParallaxMask416 = IN.ase_texcoord2.xy;
				float4 tex2DNode416 = tex2D( _ParallaxMask, uv_ParallaxMask416 );
				float4 lerpResult418 = lerp( float4( 0,0,0,0 ) , tex2DNode416 , _PushParallaxMask);
				float PupilParallaxHeight574 = _PupilParallaxHeight;
				float3 ase_worldTangent = IN.ase_texcoord4.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 paralaxOffset255 = ParallaxOffset( lerpResult418.r , PupilParallaxHeight574 , ase_tanViewDir );
				float2 ParallaxPush_Vec2580 = paralaxOffset255;
				float2 texCoord147 = IN.ase_texcoord2.xy * appendResult152.xy + ParallaxPush_Vec2580;
				float clampResult122 = clamp( ( pow( distance( appendResult149 , texCoord147 ) , ( _PupilSharpness * 7.0 ) ) + ( 1.0 - IrisPupil_MASK585 ) ) , 0.0 , 1.0 );
				float PupilMaskArea625 = clampResult122;
				float Sclera_MASK591 = tex2DNode166.g;
				float clampResult719 = clamp( ( ( _EyeVeinColorAmountA.a * 1.5 ) * Sclera_MASK591 ) , 0.0 , 1.0 );
				float4 lerpResult177 = lerp( ( _EyeBallColorGlossA * ( 1.0 - IrisPupil_MASK585 ) ) , ( _EyeVeinColorAmountA * Sclera_MASK591 ) , clampResult719);
				float4 LimbalRing_Color619 = _RingColorAmount;
				float LimbalRing_MASK590 = tex2DNode166.r;
				float eyeLimbalRingPower612 = ( _RingColorAmount.a * LimbalRing_MASK590 );
				float4 lerpResult184 = lerp( lerpResult177 , LimbalRing_Color619 , eyeLimbalRingPower612);
				float IrisPupilFactor577 = ( temp_output_151_0 * 0.017 );
				float eyeSizing616 = ( ( ( (float)10 - _BIrisSize ) * temp_output_899_0 ) + temp_output_899_0 + IrisPupilFactor577 );
				float2 temp_cast_11 = (eyeSizing616).xx;
				float2 texCoord190 = IN.ase_texcoord2.xy * temp_cast_11 + ( ( ParallaxPush_Vec2580 * float2( 0.15,0.15 ) ) + ( ( 1.0 - eyeSizing616 ) / 2.0 ) );
				float4 BaseIrisColors809 = ( ( ( ( tex2D( _IrisExtraDetail, texCoord190 ) * _IrisExtraColorAmountA ) * _IrisExtraColorAmountA.a ) * IrisPupil_MASK585 ) + ( IrisPupil_MASK585 * _IrisBaseColor ) );
				float4 temp_output_326_0 = ( PupilMaskArea625 * ( ( lerpResult184 * lerpResult184 ) + BaseIrisColors809 ) );
				float _MinimumGlow_Instance = UNITY_ACCESS_INSTANCED_PROP(CustomEyeShadersEyeShader_ASE,_MinimumGlow);
				float clampResult478 = clamp( ( 0.0 * PupilMaskArea625 ) , _MinimumGlow_Instance , 1.0 );
				float4 lerpResult568 = lerp( ( temp_output_326_0 * ( clampResult478 * 0.0 ) ) , float4( 0,0,0,0 ) , eyeLimbalRingPower612);
				float4 temp_output_674_0 = ( float4( eyeShading672 , 0.0 ) * lerpResult568 );
				float fresnelNdotV727 = dot( ase_worldNormal, SafeNormalize(_MainLightPosition.xyz) );
				float fresnelNode727 = ( 0.5 + 1.0 * pow( 1.0 - fresnelNdotV727, 1.0 ) );
				float FresnelLight732 = ( 1.0 - fresnelNode727 );
				float4 SubSurfaceArea784 = lerpResult177;
				float4 clampResult794 = clamp( ( FresnelLight732 * SubSurfaceArea784 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				float dotResult782 = dot( SafeNormalize(_MainLightPosition.xyz) , ase_worldNormal );
				float LightComponent779 = dotResult782;
				float4 clampResult795 = clamp( ( LightComponent779 * SubSurfaceArea784 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
				float4 lerpResult787 = lerp( temp_output_674_0 , ( _MainLightColor * ( clampResult794 + clampResult795 + temp_output_674_0 ) ) , _SubSurfaceFromDirectionalLight);
				
				
				float3 Albedo = ( lerpResult787 * _MainLightColor ).rgb;
				float Alpha = 1;
				float AlphaClipThreshold = 0.5;

				half4 color = half4( Albedo, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}
		
	}
	/*ase_lod*/
	CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18800
1927;7;1831;1005;-4123.817;-1193.086;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;631;-5732.188,-1686.254;Inherit;False;1277.707;559.7808;PupilControl;12;587;543;555;91;542;537;686;694;873;874;875;878;Pupil Control;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;873;-5672.611,-1205.574;Float;False;Property;_FullEyeFactor;[眼球整体放大]FullEyeFactor;22;0;Create;False;0;0;0;False;0;False;0;0.76;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;878;-5360.152,-1218.234;Half;False;FullEyeFactor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;615;-3521.69,-824.9874;Inherit;False;2148.08;465.2037;Sizing;15;616;323;578;247;604;264;265;266;267;893;895;899;896;900;902;Sizing;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-3598.22,-457.6284;Float;False;Property;_EyeSize;[虹膜放大]EyeSize;12;0;Create;False;0;0;0;False;0;False;1;0.37;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;892;-3561.603,-676.151;Inherit;False;878;FullEyeFactor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;893;-3554.45,-564.8354;Float;False;Constant;_Int0;Int 0;36;0;Create;True;0;0;0;False;0;False;2;0;False;0;1;INT;0
Node;AmplifyShaderEditor.OneMinusNode;896;-3343.309,-638.2692;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;895;-3331.353,-503.4353;Inherit;False;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;899;-3138.161,-604.1864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;266;-3067.864,-465.7361;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;265;-2848.496,-438.8314;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;264;-2664.554,-532.8677;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;-2.5,-2.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;635;-3474.641,-314.61;Inherit;False;1296.923;486.1872;Eye Local UV setup and RGB masking for Sclera, Limbal Ring and Iris Area;11;633;410;590;584;166;605;705;706;707;721;591;RGB Mixer map;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;604;-2169.318,-520.4717;Float;False;eyeSizeUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;605;-3456.858,-93.25156;Inherit;False;604;eyeSizeUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;693;-6657.773,-1941.334;Inherit;False;889.9717;218.2189;Comment;4;685;690;691;692;GetLightColorIntensity;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;166;-3081.737,-257.9168;Inherit;True;Property;_RGBMask;RGBMask;0;1;[NoScaleOffset];Create;True;0;0;0;False;1;Header(Main Textures);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;707;-2990.846,75.49301;Float;False;Property;_LimbalEdge_Adjustment;LimbalEdge_Adjustment;9;0;Create;True;0;0;0;False;0;False;0;0.457;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;685;-6625.374,-1893.515;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;705;-2647.987,-118.2514;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;706;-2479.763,-49.1507;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;690;-6441.943,-1882.795;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;691;-6151.062,-1889.845;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;662;-2148.269,-314.4674;Inherit;False;1320.225;575.4196;Make Metalness;11;723;722;585;657;655;656;660;661;663;724;725;Metalness;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;721;-2309.206,6.238053;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;585;-2113.652,59.17068;Float;False;IrisPupil_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;692;-5920.385,-1873.472;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;543;-5647.761,-1434.477;Float;False;Property;_PupilAutoDilateFactor;[瞳孔大小]PupilAutoDilateFactor;32;0;Create;False;0;0;0;False;0;False;0;10.9;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;686;-5367.417,-1635.279;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;587;-5681.011,-1524.082;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;875;-5138.271,-1294.653;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;555;-5227.093,-1567.955;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;874;-5131.141,-1441.056;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;542;-4991.899,-1533.648;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-5662.821,-1334.853;Half;False;Property;_PupilSize;[瞳孔大小]PupilSize;33;0;Create;False;0;0;0;False;0;False;70;32.7;0.001;90;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;164;-4325.575,-1592.661;Inherit;False;3085.553;637.4598;Pupil;24;625;122;286;155;285;146;600;214;213;147;149;148;152;582;154;157;153;156;577;327;151;328;545;872;Pupil Control - UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;537;-4816.12,-1435.986;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;545;-4325.713,-1507.758;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;99;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;872;-4143.746,-1562.076;Inherit;False;2;0;FLOAT;100;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;-4034.638,-1517.003;Inherit;False;2;0;FLOAT;100;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;328;-4286.182,-1348.615;Float;False;Constant;_IrisPupilBond;Iris-Pupil-Bond;23;0;Create;True;0;0;0;False;0;False;0.017;0.017;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;247;-3194.484,-765.4198;Float;False;Property;_BIrisSize;[虹膜纹理放大]IrisSize;13;0;Create;False;0;0;0;False;0;False;1;8.33;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;327;-3890.809,-1392.011;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;632;-5718.911,-1080.675;Inherit;False;733.9878;169.0557;ParallaxHeight Variable;2;257;574;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;901;-3007.817,-878.1002;Float;False;Constant;_Int1;Int 1;36;0;Create;True;0;0;0;False;0;False;10;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;-5668.911,-1030.676;Float;False;Property;_PupilParallaxHeight;PupilParallaxHeight;36;0;Create;True;0;0;0;False;0;False;2.5;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;577;-3744.449,-1291.604;Float;False;IrisPupilFactor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;902;-2774.375,-826.6811;Inherit;False;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;579;-5723.329,-855.0426;Inherit;False;2130.722;818.1102;Eye-Pupil/Iris Parallax;13;583;409;411;414;412;575;580;255;576;418;256;419;416;Parallax;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;900;-2549.668,-756.851;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;419;-4996.699,-631.905;Float;False;Property;_PushParallaxMask;PushParallaxMask;35;0;Create;True;0;0;0;False;0;False;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;574;-5266.923,-1026.62;Float;False;PupilParallaxHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;578;-2417.713,-588.0516;Inherit;False;577;IrisPupilFactor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;416;-5673.329,-785.6605;Inherit;True;Property;_ParallaxMask;ParallaxMask;34;1;[NoScaleOffset];Create;True;0;0;0;False;1;Header(Parallax Control);False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;323;-2141.998,-700.5798;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;256;-4611.694,-510.8292;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;576;-4634.585,-613.153;Inherit;False;574;PupilParallaxHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;418;-4636.011,-805.0426;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;168;-3488,576;Inherit;False;1464.509;1000.859;Inputs;18;595;594;261;182;593;133;589;284;581;612;249;617;250;283;190;618;619;622;Color Inputs;1,1,1,1;0;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;255;-4176.507,-630.6099;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-1614.072,-706.6902;Float;False;eyeSizing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;617;-3360,1344;Inherit;False;616;eyeSizing;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;580;-3865.203,-632.0921;Float;False;ParallaxPush_Vec2;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;581;-3120,1248;Inherit;False;580;ParallaxPush_Vec2;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;249;-3072,1344;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-4261.873,-1156.933;Float;False;Property;_PupilHeight1Width1;[瞳孔形状]Pupil;30;0;Create;False;0;0;0;False;0;False;1;10;0.01;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;-3814.29,-1162.465;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;153;-3603.956,-1473.407;Inherit;False;2;0;FLOAT;2;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;284;-2800,1248;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.15,0.15;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;250;-2784,1344;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;148;-3498.602,-1321.328;Inherit;False;2;0;FLOAT;2;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;283;-2544,1312;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;154;-3458.687,-1175.436;Inherit;False;2;0;FLOAT;2;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;152;-3412.445,-1491.719;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;582;-3466.066,-1375.865;Inherit;False;580;ParallaxPush_Vec2;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;618;-2624,1200;Inherit;False;616;eyeSizing;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;147;-3169.418,-1506.83;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;213;-3088.348,-1180.257;Float;False;Property;_PupilSharpness;[瞳孔模糊]PupilSharpness;31;0;Create;False;0;0;0;False;0;False;5;0.1;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;218;-1952.744,598.4021;Inherit;False;1171.74;940.1422;IrisFunk;13;613;620;177;175;210;330;185;415;187;598;170;184;719;Iris mixing;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;149;-3222.629,-1276.792;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;190;-2304,1248;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;-2.5,-2.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;591;-2598.692,-201.7008;Float;False;Sclera_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;146;-2860.775,-1437.964;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;590;-2606.34,-272.9257;Float;False;LimbalRing_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;-2769.639,-1182.017;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;185;-1903.107,1108.585;Inherit;True;Property;_IrisExtraDetail;IrisExtraDetail;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;187;-1915.38,1314.087;Float;False;Property;_IrisExtraColorAmountA;[虹膜遮罩颜色]IrisExtraColor-Amount(A);6;0;Create;False;0;0;0;False;0;False;0.08088237,0.07573904,0.04698314,0.591;0.3255562,0.4716981,0.3181733,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;600;-2587.442,-1158.279;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;170;-1908.036,772.9764;Float;False;Property;_EyeVeinColorAmountA;[血管颜色]EyeVeinColor-Amount(A);7;0;Create;False;0;0;0;False;0;False;0.375,0,0,0;0.764151,0.4645935,0.37847,0.497;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;415;-1600.302,890.2409;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-1477.025,1234.005;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;169;-757.5884,665.5753;Inherit;False;2366.183;1252.259;Mixing;28;135;134;623;20;451;603;326;627;325;626;478;489;476;103;321;322;319;636;126;251;586;775;776;777;778;809;810;814;Extra Mixing;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;182;-3439,831;Float;False;Property;_RingColorAmount;[虹膜边缘]_RingColorAmount;8;0;Create;False;0;0;0;False;0;False;0,0,0,0;0.990566,0.3504351,0.3504351,0.353;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;598;-1920.4,962.3043;Inherit;False;591;Sclera_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;285;-2172.143,-1151.367;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;589;-2880,688;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;593;-3429,1039;Inherit;False;590;LimbalRing_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;155;-2541.058,-1444.359;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;12;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;475;-1716.052,2683.718;Inherit;False;2220.814;763.4307;Eye Shading - Created local shadows around the eye (fake AO);12;672;871;483;869;864;866;863;865;861;467;860;858;Eye Shading;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;330;-1427.309,932.8994;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;595;-2464,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;126;-706.0718,1582.184;Float;False;Property;_IrisBaseColor;[虹膜颜色]IrisBaseColor;5;0;Create;False;0;0;0;False;0;False;0.4999702,0.5441177,0.4641004,1;0.1320737,0.1160314,0.0679053,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;251;-456.2553,1311.411;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;-3008,960;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;586;-727.6842,1492.685;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;286;-1955.995,-1245.143;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;858;-1638.03,2748.46;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;133;-3440,640;Float;False;Property;_EyeBallColorGlossA;[眼白颜色]EyeBallColor-Gloss(A);4;0;Create;False;0;0;0;False;2;Header(Color Customization);Space(6);False;1,1,1,0.853;0.8962264,0.8962264,0.8962264,0.8784314;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;319;-268.5711,1451.92;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;619;-3120,816;Float;False;LimbalRing_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-1506.27,780.9657;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;719;-1268.518,930.5994;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;322;-282.0901,1335.033;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;122;-1745.151,-1234.716;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;860;-1304.169,2747.889;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;612;-2768,956;Float;False;eyeLimbalRingPower;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;594;-2240,624;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;613;-1336.574,638.1853;Inherit;False;612;eyeLimbalRingPower;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;670;839.3718,2052.064;Inherit;False;2223.228;278.96;Final Mixing - Emissive;7;452;471;521;628;743;815;827;Final Mixing for Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;321;-98.59876,1373.383;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;620;-1315.666,713.5411;Inherit;False;619;LimbalRing_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;177;-1135.945,790.793;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;731;3123.164,2083.213;Inherit;False;1280.288;387.6746;Improved Light Falloff with inverse Fresnel and Light Dir;4;732;730;727;728;Light falloff simple;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;625;-1494.025,-1233.886;Float;False;PupilMaskArea;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;861;-1067.49,2753.318;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;467;-1570.481,3115.249;Float;False;Property;_EyeShadingPower;EyeShadingPower;37;0;Create;True;0;0;0;False;0;False;0.5;0.01;0.01;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;219;-1716.819,1929.655;Inherit;False;2546.831;732.6423;IrisConeCaustics;21;376;373;50;334;370;634;737;745;750;757;759;760;761;762;781;782;779;763;811;824;856;Caustics;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;728;3173.164,2155.734;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;865;-1158.297,3003.131;Inherit;False;2;2;0;FLOAT;25;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;809;137.0322,1370.998;Float;False;BaseIrisColors;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;871;-1576.091,3241.048;Float;False;Constant;_Vector1;Vector 1;38;0;Create;True;0;0;0;False;0;False;0.15,0.06,0.4;0.15,0.06,0.4;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;184;-940.8968,678.6216;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;628;875.7011,2241.544;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;863;-800.7488,2748.87;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;864;-539.245,2748.068;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;866;-1178.856,3202.184;Inherit;True;Standard;WorldNormal;LightDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;-1.13;False;2;FLOAT;0.71;False;3;FLOAT;1.21;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;781;-1653.115,2468.666;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;476;1164.363,1806.311;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;376;-1658.832,2193.938;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;810;-113.5322,1155.883;Inherit;False;809;BaseIrisColors;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;489;594.1643,1489.961;Float;False;InstancedProperty;_MinimumGlow;MinimumGlow;38;0;Create;True;0;0;0;False;0;False;0.2;0.229;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;727;3483.091,2133.213;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-711.0731,707.4684;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;626;331.6477,1245.792;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;638;1637.879,1474.012;Inherit;False;1022.617;442.3356;LocalShadowPass Extra limbal Ring effect;5;637;481;470;614;568;Shadow FX;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;782;-1278.697,2339.555;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;325;192.3898,1121.124;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;478;1393.377,1657.579;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;730;3774.033,2132.466;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;869;-183.0838,2840.006;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;326;809.9284,1364.676;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;481;1956.37,1618.656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;483;-13.7304,2848.903;Inherit;False;Lerp White To;-1;;43;047d7c189c36a62438973bad9d37b1c2;0;2;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;732;4044.787,2122.227;Float;False;FresnelLight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;850;3130.02,359.8283;Inherit;False;1881.934;962.7947;Comment;14;783;780;790;793;785;794;788;796;797;789;802;787;803;795;BestSubSurface Scatter for Eye Model 3;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;784;-955.7665,827.1627;Float;False;SubSurfaceArea;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;779;-1100.572,2288.379;Float;False;LightComponent;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;790;3196.831,409.8283;Inherit;False;732;FresnelLight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;783;3180.29,794.4534;Inherit;True;784;SubSurfaceArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;672;254.5334,2852.739;Float;False;eyeShading;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;780;3180.02,606.7944;Inherit;False;779;LightComponent;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;652;2682.394,1397.634;Inherit;False;950.9968;628.9937;Final Outputs and Pupil Color control;13;648;643;664;665;647;666;668;667;650;673;674;832;833;Final Gather;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;470;2139.102,1524.012;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;614;1811.435,1810.744;Inherit;False;612;eyeLimbalRingPower;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;793;3519.296,515.304;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;785;3518.789,722.4212;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;673;3112.564,1438.569;Inherit;False;672;eyeShading;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;568;2399.684,1767.644;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;795;3764.5,737.1391;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;674;3427.949,1519.152;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;794;3754.959,510.9361;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;796;4054.557,513.0011;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;788;4060.938,721.3491;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;797;4316.654,628.1948;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;789;3885.831,1021.573;Float;False;Property;_SubSurfaceFromDirectionalLight;SubSurfaceFromDirectionalLight;40;0;Create;True;0;0;0;False;0;False;0.5;0.785;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;671;2251.199,112.6175;Inherit;False;809.7659;371.8926;Blend normals;2;640;569;Blends Normal maps;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;848;3715.594,1390.391;Inherit;False;1443.159;515.8131;FinalEmissive;11;804;806;818;829;831;830;826;844;845;847;846;Final Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;910;2666.621,-613.9626;Inherit;False;1175.634;580.9745;Eye Reflect;13;909;911;915;916;917;918;919;914;921;922;923;925;924;Reflect CubeMap;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;167;-574.3536,48;Inherit;False;2142.244;468.7774;Normal Maps;9;331;602;139;333;607;141;138;140;606;Normal Maps;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;639;1635.956,1088.942;Inherit;False;1461.426;267.9109;Protect Iris area from eyewhite micro scatter;5;642;527;611;609;610;Mask out Microscatter;1,1,1,1;0;0
Node;AmplifyShaderEditor.LightColorNode;802;4524.5,1166.623;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;505;-511.9602,-644.9;Inherit;False;1832.025;501.339;Fake Microscatter effect - May be replaced with a simple noise-normalmap in a newer version;11;502;572;504;503;608;669;499;588;713;715;717;Microscatter;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;787;4517.122,869.8699;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;611;1938.345,1179.715;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;909;3161.372,-245.8281;Inherit;True;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;610;1663.956,1168.022;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;661;-1288.506,19.15284;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;643;3330.132,1925.106;Inherit;False;642;SMOOTHNESS_OUTPUT;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;640;2797.965,162.6175;Float;False;NORMAL_OUTPUT;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;827;929.7286,2075.794;Float;False;caustEmissission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;725;-1887.699,4.125536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;724;-2111.768,155.1683;Float;False;Property;_IrisPupilMetalness;IrisPupilMetalness;24;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;905;4232.023,-419.2168;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-150.6111,980.5873;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;777;240.8759,934.0576;Inherit;False;590;LimbalRing_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;642;2793.351,1160.468;Float;False;SMOOTHNESS_OUTPUT;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;664;3342.195,1860.429;Inherit;False;663;METALNESS_OUTPUT;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;803;4842.954,1036.472;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;922;3427.687,-518.1463;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;663;-1083.006,-143.5471;Float;False;METALNESS_OUTPUT;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;776;217.8759,859.0576;Float;False;Property;_LimbalRingGloss;LimbalRingGloss;10;0;Create;True;0;0;0;False;0;False;0;0.408;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;608;1064.798,-255.6428;Float;False;microScatter;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;845;4771.337,1668.933;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;722;-2105.917,-106.2091;Float;False;Property;_EyeBallMetalness;EyeBallMetalness;25;0;Create;True;0;0;0;False;0;False;0;0.329;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;623;-351.8134,813.577;Inherit;False;622;EyeBallGloss;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;919;2814.176,-460.8659;Float;False;Property;_Rotate_Y;[旋转高光]Rotate_Y;19;0;Create;False;0;0;0;False;0;False;0;219;-360;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;723;-2128.732,-215.2754;Float;False;Property;_LimbalRingMetalness;LimbalRingMetalness;23;0;Create;True;0;0;0;False;1;Header(Metalness);False;0;0.047;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;824;282.5758,2504.359;Float;False;causticInDark;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;832;3186.553,1655.089;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;904;3860.476,-436.045;Inherit;True;Property;_EyeReflectCubeMap;[反射高光]EyeReflectCubeMap;16;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ReflectOpNode;915;3019.57,-322.0942;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;830;4327.083,1479.824;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;135;80.12472,988.3787;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;656;-1683.046,-62.42888;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;831;4043.524,1535.406;Inherit;False;824;causticInDark;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;923;3673.007,-329.2488;Float;False;// compute sin/cos of fAngle$fAngle *= UNITY_PI / 180.0@$float2 vSinCos@$#ifdef OPENGL$	vSinCos.x = sin(fAngle)@$	vSinCos.y = cos(fAngle)@$#else$	sincos(fAngle, vSinCos.x, vSinCos.y)@$#endif$const float c = vSinCos.y@$const float s = vSinCos.x@$const float t = 1.0 - c@$const float x = vAxis.x@$const float y = vAxis.y@$const float z = vAxis.z@$float3x3 RotateMatrix = float3x3(t * x * x + c,      t * x * y - s * z,  t * x * z + s * y,$				t * x * y + s * z,  t * y * y + c,      t * y * z - s * x,$				t * x * z - s * y,  t * y * z + s * x,  t * z * z + c)@$return mul(RotateMatrix,uvw)@;3;False;3;True;vAxis;FLOAT3;0,0,0;In;;Float;False;True;fAngle;FLOAT;0;In;;Float;False;True;uvw;FLOAT3;0,0,0;In;;Float;False;RotationMatrix;True;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;609;1657.123,1258.416;Inherit;False;608;microScatter;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;775;698.8759,941.0576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;925;3471.758,-426.8354;Float;False;Property;_XYZ_Axis;XYZ_Axis;21;0;Create;True;0;0;0;False;0;False;0,0,0;1,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;921;3129.687,-538.1463;Float;False;Property;_ReflectScale;[高光放大]ReflectScale;17;0;Create;False;0;0;0;False;0;False;0;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;660;-1491.204,-109.2472;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;527;2256.172,1242.286;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LightColorNode;806;3771.776,1560.623;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;833;3404.886,1640.262;Float;False;PupilGlow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;818;4036.508,1640.483;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;911;3372.531,-611.3324;Float;False;Property;_EyeReflectFactor;[高光系数]EyeReflectFactor;18;0;Create;False;0;0;0;False;0;False;0;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;844;4039.651,1791.205;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;655;-1801.268,-260.4674;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;826;4537.544,1572.856;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;829;4028.655,1440.391;Inherit;False;827;caustEmissission;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;804;3765.594,1730.662;Float;False;PreEmissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;924;3365.758,-170.8354;Float;False;Property;_RotateXYZ;[旋转高光]RotateXYZ;20;0;Create;False;0;0;0;False;0;False;0;-49;-360;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;525;2474.173,966.8337;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;641;5391.926,1527.195;Inherit;False;640;NORMAL_OUTPUT;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;846;5004.753,1708.175;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;-1763.756,67.64504;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;918;3241.736,-420.6177;Float;False;float alpha = degrees * UNITY_PI / 180.0@$float sina, cosa@$				sincos(alpha, sina, cosa)@$				float2x2 m = float2x2(cosa, -sina, sina, cosa)@$return float3(mul(m, normal.xz), normal.y).xzy@;3;False;2;True;normal;FLOAT3;0,0,0;In;;Float;False;True;degrees;FLOAT;0;In;;Float;False;RotateYDegrees;True;False;0;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;778;519.8759,895.0576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;847;4697.979,1781.792;Inherit;False;833;PupilGlow;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;-24.99918,2018.613;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-753.7518,947.6635;Float;False;Property;_LensGloss;[高光点放大]LensGloss;14;0;Create;False;0;0;0;False;0;False;0.98;0.133;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;648;3441.668,1712.301;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;637;1687.879,1711.533;Inherit;False;LocalShadowing;-1;;40;;0;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;715;-87.53503,-401.5688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;763;158.206,1963.214;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;750;-326.8658,2509.578;Float;False;Property;_CausticFX_inDarkness;CausticFX_inDarkness;28;0;Create;True;0;0;0;False;0;False;17;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;762;204.3723,2174.062;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;669;-43.51121,-496.9287;Inherit;False;MicroScatterScale_vec2;-1;;42;;0;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;627;795.5042,1280.395;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;636;621.0922,1793.227;Inherit;False;LightDirectionZone_float;-1;;38;;0;0;0
Node;AmplifyShaderEditor.OneMinusNode;713;-250.4354,-532.1979;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;760;-27.14433,2196.143;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;811;-586.6219,1953.813;Inherit;False;809;BaseIrisColors;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;757;-153.9395,2331.472;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-506.7211,-583.7661;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;370;-650.2144,2062.136;Inherit;True;Property;_CausticMask;CausticMask;26;1;[NoScaleOffset];Create;True;0;0;0;False;1;Header(Caustic FX);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;373;-934.2298,2080.128;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;856;-495.0187,2376.763;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;694;-5715.541,-1608.325;Inherit;False;PupilAffectedByLight_float;-1;;24;;0;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;575;-5667.397,-373.1516;Inherit;False;574;PupilParallaxHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;412;-5246.854,-223.3449;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;414;-5227.638,-363.4906;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;411;-4944.352,-301.8562;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;409;-4628.915,-351.2112;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;717;97.39243,-306.1013;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;583;-4153.616,-354.6765;Float;False;ParallaxOffset_Vec2;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;410;-3143.635,-18.3141;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;737;-1067.431,2407.645;Inherit;False;732;FresnelLight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;633;-2953.703,-10.51019;Float;False;eyeLocalUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;759;-803.2366,2391.976;Inherit;False;ConstantBiasScale;-1;;33;63208df05c83e8e49a48ffbdce2e43a0;0;3;3;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;634;-1561.857,2019.873;Inherit;False;633;eyeLocalUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-764.0728,2238.058;Float;False;Property;_CausticPower;CausticPower;27;0;Create;True;0;0;0;False;0;False;17;0.5;0.5;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;584;-3424.641,63.08065;Inherit;False;583;ParallaxOffset_Vec2;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;451;1172.024,1472.768;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;761;440.1433,2096.835;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;499;353.9738,-223.3932;Float;False;Property;_Eyeball_microScatter;Eyeball_microScatter;39;0;Create;True;0;0;0;False;0;False;0;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;452;2057.326,2164.549;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;332;1661.057,67.2785;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;602;1137.646,384;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;916;2628.678,-368.4268;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;569;2474.863,224.9719;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;666;2805.619,1764.239;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;572;404.3301,-453.4742;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;471;2670.734,2118.573;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;622;-3120,736;Float;False;EyeBallGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;917;2883.827,-326.5647;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;914;2686.927,-197.9115;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;603;-734.5588,1055.458;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;665;3041.243,1719.121;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;521;2887.6,2102.064;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;647;2707.268,1444.284;Float;False;Property;_PupilColorEmissivenessA;[瞳孔颜色]PupilColor-Emissiveness(A);29;0;Create;False;0;0;0;False;2;Header(Pupil Control);Space(6);False;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;668;2732.629,1848.105;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;139;737.6464,320;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;502;1123.114,-510.9321;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;607;641.6464,80;Inherit;False;604;eyeSizeUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;606;-126.3536,208;Inherit;False;604;eyeSizeUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;504;816.5957,-357.6282;Inherit;False;3;3;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;814;1390.149,1505.289;Float;False;BaseColoring;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;745;657.967,2126.984;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;667;2859.071,1863.319;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;503;373.7202,-606.47;Float;False;Constant;_FlatNormal;FlatNormal;31;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;650;2701.278,1917.861;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;140;225.6464,64;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;331;945.6464,80;Inherit;True;Property;_Sclera_Normal;Sclera_Normal;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;141;227.6464,474;Float;False;Property;_LensPush;[高光点推进]LensPush;15;0;Create;False;0;0;0;False;0;False;0.64;0.788;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;743;1523.932,2170.736;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;138;113.6464,240;Inherit;True;Property;_Lens_Base_Normal;Lens_Base_Normal;3;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;815;1458.395,2093.988;Inherit;False;814;BaseColoring;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;333;577.6464,144;Float;False;Property;_ScleraBumpScale;ScleraBumpScale;11;0;Create;True;0;0;0;False;0;False;0;0.273;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;930;6181.279,1606.051;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;926;6181.279,1606.051;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;927;6181.279,1606.051;Float;False;True;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;11;Custom/EyeShaders/EyeShader_ASE;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;17;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;36;Workflow;1;Surface;0;  Refraction Model;0;  Blend;0;Two Sided;1;Fragment Normal Space,InvertActionOnDeselection;0;Transmission;0;  Transmission Shadow;0.5,False,-1;Translucency;0;  Translucency Strength;1,False,-1;  Normal Distortion;0.5,False,-1;  Scattering;2,False,-1;  Direct;0.9,False,-1;  Ambient;0.1,False,-1;  Shadow;0.5,False,-1;Cast Shadows;0;  Use Shadow Threshold;0;Receive Shadows;0;GPU Instancing;1;LOD CrossFade;0;Built-in Fog;0;_FinalColorxAlpha;0;Meta Pass;0;Override Baked GI;0;Extra Pre Pass;0;DOTS Instancing;0;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Vertex Position,InvertActionOnDeselection;1;0;6;False;True;False;True;False;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;928;6181.279,1606.051;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;929;6181.279,1606.051;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;931;6181.279,1606.051;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=Universal2D;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;878;0;873;0
WireConnection;896;0;892;0
WireConnection;895;0;893;0
WireConnection;895;1;267;0
WireConnection;899;0;896;0
WireConnection;899;1;895;0
WireConnection;266;0;899;0
WireConnection;265;0;266;0
WireConnection;264;0;899;0
WireConnection;264;1;265;0
WireConnection;604;0;264;0
WireConnection;166;1;605;0
WireConnection;705;0;166;3
WireConnection;705;1;166;1
WireConnection;706;0;166;3
WireConnection;706;1;705;0
WireConnection;706;2;707;0
WireConnection;690;0;685;1
WireConnection;691;0;690;0
WireConnection;691;1;690;1
WireConnection;691;2;690;2
WireConnection;721;0;706;0
WireConnection;585;0;721;0
WireConnection;692;0;691;0
WireConnection;686;0;692;0
WireConnection;875;0;543;0
WireConnection;875;1;878;0
WireConnection;555;0;686;0
WireConnection;555;1;587;0
WireConnection;874;0;543;0
WireConnection;874;1;875;0
WireConnection;542;0;555;0
WireConnection;542;1;874;0
WireConnection;537;0;91;0
WireConnection;537;1;542;0
WireConnection;545;0;537;0
WireConnection;872;1;545;0
WireConnection;151;1;872;0
WireConnection;327;0;151;0
WireConnection;327;1;328;0
WireConnection;577;0;327;0
WireConnection;902;0;901;0
WireConnection;902;1;247;0
WireConnection;900;0;902;0
WireConnection;900;1;899;0
WireConnection;574;0;257;0
WireConnection;323;0;900;0
WireConnection;323;1;899;0
WireConnection;323;2;578;0
WireConnection;418;1;416;0
WireConnection;418;2;419;0
WireConnection;255;0;418;0
WireConnection;255;1;576;0
WireConnection;255;2;256;0
WireConnection;616;0;323;0
WireConnection;580;0;255;0
WireConnection;249;0;617;0
WireConnection;157;0;156;0
WireConnection;153;0;151;0
WireConnection;153;1;156;0
WireConnection;284;0;581;0
WireConnection;250;0;249;0
WireConnection;148;0;151;0
WireConnection;283;0;284;0
WireConnection;283;1;250;0
WireConnection;154;0;151;0
WireConnection;154;1;157;0
WireConnection;152;0;151;0
WireConnection;152;1;153;0
WireConnection;147;0;152;0
WireConnection;147;1;582;0
WireConnection;149;0;148;0
WireConnection;149;1;154;0
WireConnection;190;0;618;0
WireConnection;190;1;283;0
WireConnection;591;0;166;2
WireConnection;146;0;149;0
WireConnection;146;1;147;0
WireConnection;590;0;166;1
WireConnection;214;0;213;0
WireConnection;185;1;190;0
WireConnection;415;0;170;4
WireConnection;210;0;185;0
WireConnection;210;1;187;0
WireConnection;285;0;600;0
WireConnection;155;0;146;0
WireConnection;155;1;214;0
WireConnection;330;0;415;0
WireConnection;330;1;598;0
WireConnection;595;0;589;0
WireConnection;251;0;210;0
WireConnection;251;1;187;4
WireConnection;261;0;182;4
WireConnection;261;1;593;0
WireConnection;286;0;155;0
WireConnection;286;1;285;0
WireConnection;319;0;586;0
WireConnection;319;1;126;0
WireConnection;619;0;182;0
WireConnection;175;0;170;0
WireConnection;175;1;598;0
WireConnection;719;0;330;0
WireConnection;322;0;251;0
WireConnection;322;1;586;0
WireConnection;122;0;286;0
WireConnection;860;0;858;2
WireConnection;612;0;261;0
WireConnection;594;0;133;0
WireConnection;594;1;595;0
WireConnection;321;0;322;0
WireConnection;321;1;319;0
WireConnection;177;0;594;0
WireConnection;177;1;175;0
WireConnection;177;2;719;0
WireConnection;625;0;122;0
WireConnection;861;0;860;0
WireConnection;861;1;858;2
WireConnection;865;1;467;0
WireConnection;809;0;321;0
WireConnection;184;0;177;0
WireConnection;184;1;620;0
WireConnection;184;2;613;0
WireConnection;863;0;861;0
WireConnection;863;1;861;0
WireConnection;863;2;861;0
WireConnection;863;3;861;0
WireConnection;864;0;863;0
WireConnection;864;1;865;0
WireConnection;866;1;871;1
WireConnection;866;2;871;2
WireConnection;866;3;871;3
WireConnection;476;1;628;0
WireConnection;727;4;728;0
WireConnection;103;0;184;0
WireConnection;103;1;184;0
WireConnection;782;0;376;0
WireConnection;782;1;781;0
WireConnection;325;0;103;0
WireConnection;325;1;810;0
WireConnection;478;0;476;0
WireConnection;478;1;489;0
WireConnection;730;0;727;0
WireConnection;869;0;864;0
WireConnection;869;1;866;0
WireConnection;326;0;626;0
WireConnection;326;1;325;0
WireConnection;481;0;478;0
WireConnection;483;1;869;0
WireConnection;483;2;467;0
WireConnection;732;0;730;0
WireConnection;784;0;177;0
WireConnection;779;0;782;0
WireConnection;672;0;483;0
WireConnection;470;0;326;0
WireConnection;470;1;481;0
WireConnection;793;0;790;0
WireConnection;793;1;783;0
WireConnection;785;0;780;0
WireConnection;785;1;783;0
WireConnection;568;0;470;0
WireConnection;568;2;614;0
WireConnection;795;0;785;0
WireConnection;674;0;673;0
WireConnection;674;1;568;0
WireConnection;794;0;793;0
WireConnection;788;0;794;0
WireConnection;788;1;795;0
WireConnection;788;2;674;0
WireConnection;797;0;796;0
WireConnection;797;1;788;0
WireConnection;787;0;674;0
WireConnection;787;1;797;0
WireConnection;787;2;789;0
WireConnection;611;0;610;0
WireConnection;661;0;660;0
WireConnection;640;0;569;0
WireConnection;827;0;745;0
WireConnection;725;0;585;0
WireConnection;905;0;911;0
WireConnection;905;1;904;0
WireConnection;905;2;909;0
WireConnection;134;0;20;0
WireConnection;134;1;603;0
WireConnection;642;0;525;0
WireConnection;803;0;787;0
WireConnection;803;1;802;0
WireConnection;922;0;921;0
WireConnection;663;0;661;0
WireConnection;608;0;504;0
WireConnection;845;0;826;0
WireConnection;845;1;844;0
WireConnection;824;0;750;0
WireConnection;832;0;647;0
WireConnection;832;1;665;0
WireConnection;904;1;923;0
WireConnection;915;0;917;0
WireConnection;915;1;914;0
WireConnection;830;0;829;0
WireConnection;830;1;831;0
WireConnection;135;0;623;0
WireConnection;135;1;134;0
WireConnection;135;2;603;0
WireConnection;656;0;722;0
WireConnection;656;1;725;0
WireConnection;923;0;925;0
WireConnection;923;1;924;0
WireConnection;923;2;918;0
WireConnection;775;0;778;0
WireConnection;775;1;135;0
WireConnection;660;0;655;0
WireConnection;660;1;656;0
WireConnection;660;2;657;0
WireConnection;527;0;611;0
WireConnection;527;1;609;0
WireConnection;833;0;832;0
WireConnection;818;0;806;0
WireConnection;818;1;804;0
WireConnection;655;0;590;0
WireConnection;655;1;723;0
WireConnection;826;0;830;0
WireConnection;826;1;818;0
WireConnection;804;0;648;0
WireConnection;525;0;775;0
WireConnection;525;2;527;0
WireConnection;846;0;845;0
WireConnection;846;1;847;0
WireConnection;846;2;905;0
WireConnection;657;0;585;0
WireConnection;657;1;724;0
WireConnection;918;0;915;0
WireConnection;918;1;919;0
WireConnection;778;0;776;0
WireConnection;778;1;777;0
WireConnection;334;0;811;0
WireConnection;334;1;370;0
WireConnection;334;2;757;0
WireConnection;648;0;521;0
WireConnection;648;1;568;0
WireConnection;648;2;665;0
WireConnection;715;0;713;0
WireConnection;763;0;811;0
WireConnection;763;1;334;0
WireConnection;762;0;811;0
WireConnection;762;1;760;0
WireConnection;713;0;588;0
WireConnection;760;0;811;0
WireConnection;760;1;370;0
WireConnection;760;2;50;0
WireConnection;757;0;50;0
WireConnection;757;1;856;0
WireConnection;370;1;373;0
WireConnection;373;0;634;0
WireConnection;373;2;376;1
WireConnection;856;0;759;0
WireConnection;414;0;575;0
WireConnection;411;0;416;0
WireConnection;411;1;414;0
WireConnection;411;2;412;0
WireConnection;409;1;411;0
WireConnection;717;0;715;0
WireConnection;583;0;409;0
WireConnection;410;0;605;0
WireConnection;410;1;584;0
WireConnection;633;0;410;0
WireConnection;759;3;737;0
WireConnection;451;0;627;0
WireConnection;451;1;489;0
WireConnection;451;2;326;0
WireConnection;761;0;763;0
WireConnection;761;1;762;0
WireConnection;761;2;750;0
WireConnection;452;0;815;0
WireConnection;452;1;743;0
WireConnection;332;0;502;0
WireConnection;332;1;331;0
WireConnection;569;0;332;0
WireConnection;569;1;139;0
WireConnection;569;2;602;0
WireConnection;666;0;668;0
WireConnection;471;0;568;0
WireConnection;471;1;568;0
WireConnection;471;2;452;0
WireConnection;622;0;133;4
WireConnection;917;0;916;0
WireConnection;914;0;569;0
WireConnection;665;0;647;4
WireConnection;665;1;666;0
WireConnection;521;0;471;0
WireConnection;668;0;667;0
WireConnection;139;0;140;0
WireConnection;139;1;138;0
WireConnection;139;2;141;0
WireConnection;502;0;503;0
WireConnection;502;1;572;0
WireConnection;502;2;504;0
WireConnection;504;0;572;0
WireConnection;504;1;717;0
WireConnection;504;2;499;0
WireConnection;814;0;451;0
WireConnection;745;0;761;0
WireConnection;667;0;650;0
WireConnection;331;1;607;0
WireConnection;331;5;333;0
WireConnection;743;0;745;0
WireConnection;743;1;628;0
WireConnection;138;1;606;0
WireConnection;927;0;803;0
WireConnection;927;1;641;0
WireConnection;927;2;846;0
WireConnection;927;3;664;0
WireConnection;927;4;643;0
ASEEND*/
//CHKSM=34673F2114F2E4B7055EFAE789F8B6D6CA530C03