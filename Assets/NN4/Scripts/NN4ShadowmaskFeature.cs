using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using System.Collections.Generic;

public class NN4ShadowmaskFeature : ScriptableRendererFeature
{
    [System.Serializable, ReloadGroup]
    public class NN4ShadowmaskFeatureSettings
    {
        [Range(0, 0.01f)]
        [SerializeField]
        public float ShadowBias = 0.0005f;
        public Color ShadowColor = Color.grey;
        public LayerMask OpaqueLayerMask;        
        public Material SkinShadowMask;
    }
    NN4ShadowmaskPass m_NN4ShadowmaskPass;

    public NN4ShadowmaskFeatureSettings m_Settings;

    public override void Create()
    {
        m_NN4ShadowmaskPass = new NN4ShadowmaskPass("NN4MainCamera.Render.Shadowmask", RenderPassEvent.BeforeRenderingPrepasses, RenderQueueRange.opaque, m_Settings.OpaqueLayerMask);
        m_NN4ShadowmaskPass._ShadowParams = m_Settings.ShadowColor;
        m_NN4ShadowmaskPass._ShadowParams.w = m_Settings.ShadowBias;
        m_NN4ShadowmaskPass.Settings = m_Settings;
    }

    // Here you can inject one or multiple render passes in the renderer.
    // This method is called when setting up the renderer once per-camera.
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (m_Settings.SkinShadowMask != null)
            renderer.EnqueuePass(m_NN4ShadowmaskPass);
    }
    public class NN4ShadowmaskPass : ScriptableRenderPass
    {
        List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();
        string m_ProfilerTag;
        ProfilingSampler m_ProfilingSampler;
        FilteringSettings m_FilteringSettings;
        RenderStateBlock m_RenderStateBlock;
        Camera m_MainCamera;

        RenderTargetHandle m_NN4Shadowmask;
        RenderTexture m_NN4ShadowmaskTexture;

        public static int _CustomWorldToShadowID;
        public static int _CustomShadowParams;
        Matrix4x4 _MatrixWorldToShadow;
        public Vector4 _ShadowParams;

        public NN4ShadowmaskFeatureSettings Settings;
        public NN4ShadowmaskPass(string profilerTag, RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask)//, StencilState stencilState, int stencilReference)
        {
            m_ProfilerTag = profilerTag;
            m_ProfilingSampler = new ProfilingSampler(profilerTag);

            m_ShaderTagIdList.Add(new ShaderTagId("ShadowCaster"));

            renderPassEvent = evt;

            m_NN4Shadowmask.Init("posm_ShadowMaskSkin");

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
        const int s_shadowmask_size = 2048;

        // This method is called before executing the render pass.
        // It can be used to configure render targets and their clear state. Also to create temporary render target textures.
        // When empty this render pass will render to the active camera render target.
        // You should never call CommandBuffer.SetRenderTarget. Instead call <c>ConfigureTarget</c> and <c>ConfigureClear</c>.
        // The render pipeline will ensure target setup and clearing happens in an performance manner.
        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
        {
            if (m_MainCamera == null)
            {
                GameObject obj = GameObject.FindGameObjectWithTag("MainCamera");
                if (null == obj)
                    return;
                m_MainCamera = obj.GetComponent<Camera>();                
            }

            m_NN4ShadowmaskTexture = RenderTexture.GetTemporary(s_shadowmask_size/2, s_shadowmask_size/2, k_ShadowmapBufferBits, RenderTextureFormat.R16);
            m_NN4ShadowmaskTexture.filterMode =  FilterMode.Bilinear;
            m_NN4ShadowmaskTexture.wrapMode = TextureWrapMode.Clamp;
            m_NN4ShadowmaskTexture.name = "_posm_ShadowMaskSkin";
            ConfigureTarget(new RenderTargetIdentifier(m_NN4ShadowmaskTexture));            
            ConfigureClear(ClearFlag.All, Color.black);
        }

        // Here you can implement the rendering logic.
        // Use <c>ScriptableRenderContext</c> to issue drawing commands or execute command buffers
        // https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html
        // You don't have to call ScriptableRenderContext.submit, the render pipeline will call it at specific points in the pipeline.
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (null == m_MainCamera)
                return;

            _MatrixWorldToShadow = m_MainCamera.projectionMatrix * m_MainCamera.worldToCameraMatrix;                                  
            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            using (new ProfilingScope(cmd, m_ProfilingSampler))
            {
                cmd.SetGlobalMatrix(_CustomWorldToShadowID, _MatrixWorldToShadow);
                cmd.SetGlobalVector(_CustomShadowParams, _ShadowParams);
                //change view projection matrix using cmd buffer
                cmd.SetViewProjectionMatrices(m_MainCamera.worldToCameraMatrix, m_MainCamera.projectionMatrix);
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                var sortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
                var drawSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortFlags);
                drawSettings.overrideMaterial = Settings.SkinShadowMask;
                var filterSettings = m_FilteringSettings;

                ////only clear depth buffer here
                ///  Clear Depth, Clear Color
//                cmd.ClearRenderTarget(true, false, Color.clear);
                context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref filterSettings, ref m_RenderStateBlock);

                cmd.SetGlobalTexture(m_NN4Shadowmask.id, m_NN4ShadowmaskTexture);
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

            if (m_NN4ShadowmaskTexture)
            {
                RenderTexture.ReleaseTemporary(m_NN4ShadowmaskTexture);
                m_NN4ShadowmaskTexture = null;
            }
        }
    }
}


