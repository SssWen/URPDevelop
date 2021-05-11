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
        public float DepthBias = 0.0f;
        public LayerMask OpaqueLayerMask;        
        public Material SkinShadowMask;
    }
    NN4ShadowmaskPass m_NN4ShadowmaskPass;

    public NN4ShadowmaskFeatureSettings m_Settings;

    public override void Create()
    {
        m_NN4ShadowmaskPass = new NN4ShadowmaskPass("NN4MainCamera.Render.Shadowmask", RenderPassEvent.BeforeRenderingPrepasses, RenderQueueRange.opaque, m_Settings.OpaqueLayerMask);
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

        public NN4ShadowmaskFeatureSettings Settings;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="profilerTag">FrameDebugName</param>
        /// <param name="evt"></param>
        /// <param name="renderQueueRange"></param>
        /// <param name="layerMask"></param>
        public NN4ShadowmaskPass(string profilerTag, RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask)
        {
            m_ProfilerTag = profilerTag;
            m_ProfilingSampler = new ProfilingSampler(profilerTag);
            m_ShaderTagIdList.Add(new ShaderTagId("UniversalForward"));
            renderPassEvent = evt;
            m_NN4Shadowmask.Init("posm_ShadowMaskSkin");
            m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
            m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);                                    
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

            m_NN4ShadowmaskTexture = RenderTexture.GetTemporary(s_shadowmask_size/2, s_shadowmask_size/2, k_ShadowmapBufferBits, RenderTextureFormat.RHalf);
//            m_NN4ShadowmaskTexture.filterMode =  FilterMode.Bilinear;
//            m_NN4ShadowmaskTexture.wrapMode = TextureWrapMode.Clamp;
            m_NN4ShadowmaskTexture.name = "posm_ShadowMaskSkin";
            ConfigureTarget(new RenderTargetIdentifier(m_NN4ShadowmaskTexture));
            ConfigureClear(ClearFlag.All, Color.white);
        }

        // Here you can implement the rendering logic.
        // Use <c>ScriptableRenderContext</c> to issue drawing commands or execute command buffers
        // https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html
        // You don't have to call ScriptableRenderContext.submit, the render pipeline will call it at specific points in the pipeline.
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (null == m_MainCamera)
                return;
            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            using (new ProfilingScope(cmd, m_ProfilingSampler))
            {
                var sortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
                var drawSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortFlags);
                drawSettings.overrideMaterial = Settings.SkinShadowMask;
                var filterSettings = m_FilteringSettings;
                Shader.SetGlobalTexture(m_NN4Shadowmask.id, m_NN4ShadowmaskTexture);
                context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref filterSettings, ref m_RenderStateBlock);
                
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


