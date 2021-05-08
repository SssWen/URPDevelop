using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using System.Collections.Generic;

public class NN4ShadowmapFeature : ScriptableRendererFeature
{
    [System.Serializable, ReloadGroup]
    public class NN4ShadowmapFeatureSettings
    {
        [Range(0, 0.01f)]
        [SerializeField]
        public float ShadowBias = 0.0005f;
        public Color ShadowColor = Color.grey;
        public LayerMask OpaqueLayerMask;
        public LayerMask TransparentLayerMask;
        public Material DepthMaterial;
    }
    NN4ShadowmapPass m_NN4ShadowmapPass;

    public NN4ShadowmapFeatureSettings m_Settings;

    public override void Create()
    {
        m_NN4ShadowmapPass = new NN4ShadowmapPass("NN4Camera.Render.Shadowmap", RenderPassEvent.BeforeRenderingShadows, RenderQueueRange.opaque, m_Settings.OpaqueLayerMask);
        m_NN4ShadowmapPass._ShadowParams = m_Settings.ShadowColor;
        m_NN4ShadowmapPass._ShadowParams.w = m_Settings.ShadowBias;
        m_NN4ShadowmapPass.Settings = m_Settings;
    }

    // Here you can inject one or multiple render passes in the renderer.
    // This method is called when setting up the renderer once per-camera.
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (m_Settings.DepthMaterial != null)
            renderer.EnqueuePass(m_NN4ShadowmapPass);
    }
    public class NN4ShadowmapPass : ScriptableRenderPass
    {
        List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();
        string m_ProfilerTag;
        ProfilingSampler m_ProfilingSampler;
        FilteringSettings m_FilteringSettings;
        RenderStateBlock m_RenderStateBlock;
        Camera m_ShadowCamera;

        RenderTargetHandle m_MainLightShadowmap;
        RenderTexture m_MainLightShadowmapTexture;

        public static int _CustomWorldToShadowID;
        public static int _CustomShadowParams;
        Matrix4x4 _MatrixWorldToShadow;
        public Vector4 _ShadowParams;

        public NN4ShadowmapFeatureSettings Settings;
        public NN4ShadowmapPass(string profilerTag, RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask)//, StencilState stencilState, int stencilReference)
        {
            m_ProfilerTag = profilerTag;
            m_ProfilingSampler = new ProfilingSampler(profilerTag);

            m_ShaderTagIdList.Add(new ShaderTagId("ShadowCaster"));

            renderPassEvent = evt;

            m_MainLightShadowmap.Init("posm_ShadowMap");

            m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
            m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);

            //if (stencilState.enabled)
            //{
            //    m_RenderStateBlock.stencilReference = stencilReference;
            //    m_RenderStateBlock.mask = RenderStateMask.Stencil;
            //    m_RenderStateBlock.stencilState = stencilState;
            //}
            _CustomWorldToShadowID = Shader.PropertyToID("_ZorroShadowMatrix");
            _CustomShadowParams = Shader.PropertyToID("_ZorroShadowParams");            
        }

        const int k_ShadowmapBufferBits = 32;
        const int s_shadowmap_size = 2048;

        // This method is called before executing the render pass.
        // It can be used to configure render targets and their clear state. Also to create temporary render target textures.
        // When empty this render pass will render to the active camera render target.
        // You should never call CommandBuffer.SetRenderTarget. Instead call <c>ConfigureTarget</c> and <c>ConfigureClear</c>.
        // The render pipeline will ensure target setup and clearing happens in an performance manner.
        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
        {
            GameObject obj = GameObject.FindGameObjectWithTag("ShadowCamera");
            if (null == obj)
                return;
            m_ShadowCamera = obj.GetComponent<Camera>();            
            if (null == m_ShadowCamera)
                return;
            if(m_ShadowCamera.enabled)
                m_ShadowCamera.enabled = false;

            m_MainLightShadowmapTexture = RenderTexture.GetTemporary(s_shadowmap_size/2, s_shadowmap_size/2, k_ShadowmapBufferBits, RenderTextureFormat.R16);
            m_MainLightShadowmapTexture.filterMode =  FilterMode.Bilinear;
            m_MainLightShadowmapTexture.wrapMode = TextureWrapMode.Clamp;
            m_MainLightShadowmapTexture.name = "_posm_ShadowMap";
            ConfigureTarget(new RenderTargetIdentifier(m_MainLightShadowmapTexture));            
            ConfigureClear(ClearFlag.All, Color.black);
        }

        // Here you can implement the rendering logic.
        // Use <c>ScriptableRenderContext</c> to issue drawing commands or execute command buffers
        // https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html
        // You don't have to call ScriptableRenderContext.submit, the render pipeline will call it at specific points in the pipeline.
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (null == m_ShadowCamera)
                return;

            _MatrixWorldToShadow = m_ShadowCamera.projectionMatrix * m_ShadowCamera.worldToCameraMatrix;                                  
            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            using (new ProfilingScope(cmd, m_ProfilingSampler))
            {
                cmd.SetGlobalMatrix(_CustomWorldToShadowID, _MatrixWorldToShadow);
                cmd.SetGlobalVector(_CustomShadowParams, _ShadowParams);
                //change view projection matrix using cmd buffer
                cmd.SetViewProjectionMatrices(m_ShadowCamera.worldToCameraMatrix, m_ShadowCamera.projectionMatrix);
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                var sortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
                var drawSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortFlags);
                drawSettings.overrideMaterial = Settings.DepthMaterial;
                var filterSettings = m_FilteringSettings;

                ////only clear depth buffer here
                ///  Clear Depth, Clear Color
//                cmd.ClearRenderTarget(true, false, Color.clear);
                context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref filterSettings, ref m_RenderStateBlock);

                cmd.SetGlobalTexture(m_MainLightShadowmap.id, m_MainLightShadowmapTexture);
                //cmd.SetGlobalMatrix(_CustomWorldToShadowID, _MatrixWorldToShadow);
            }
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }

        /// Cleanup any allocated resources that were created during the execution of this render pass.
        public override void FrameCleanup(CommandBuffer cmd)
        {
            if (cmd == null)
                throw new ArgumentNullException("cmd");

            if (m_MainLightShadowmapTexture)
            {
                RenderTexture.ReleaseTemporary(m_MainLightShadowmapTexture);
                m_MainLightShadowmapTexture = null;
            }
        }
    }
}


