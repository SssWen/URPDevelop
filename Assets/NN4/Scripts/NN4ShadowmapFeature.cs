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
        public float ShadowBias = 0.0f;
        public float DepthBias = 0.0f;
        public float DepthSlopeBias = -0.005f;
        
        public LayerMask OpaqueLayerMask;        
        public Material DepthMaterial;
    }
    NN4ShadowmapPass m_NN4ShadowmapPass;

    public NN4ShadowmapFeatureSettings m_Settings;

    public override void Create()
    {
        m_NN4ShadowmapPass = new NN4ShadowmapPass("NN4Camera.Render.Shadowmap", RenderPassEvent.BeforeRenderingShadows, RenderQueueRange.opaque, m_Settings.OpaqueLayerMask);                
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

        RenderTargetHandle m_NN4Shadowmap;
        RenderTexture m_NN4ShadowmapTexture;
        Matrix4x4 _MatrixWorldToShadow;
        

        public NN4ShadowmapFeatureSettings Settings;
        public NN4ShadowmapPass(string profilerTag, RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask)//, StencilState stencilState, int stencilReference)
        {            
            m_ProfilerTag = profilerTag;
            m_ProfilingSampler = new ProfilingSampler(profilerTag);

            m_ShaderTagIdList.Add(new ShaderTagId("UniversalForward"));

            renderPassEvent = evt;

            m_NN4Shadowmap.Init("posm_ShadowMap");

            m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
            m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);          
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

            m_NN4ShadowmapTexture = RenderTexture.GetTemporary(s_shadowmap_size/2, s_shadowmap_size/2, k_ShadowmapBufferBits, RenderTextureFormat.R16);
            m_NN4ShadowmapTexture.filterMode =  FilterMode.Bilinear;
            m_NN4ShadowmapTexture.wrapMode = TextureWrapMode.Clamp;
            m_NN4ShadowmapTexture.name = "posm_ShadowMap";
            ConfigureTarget(new RenderTargetIdentifier(m_NN4ShadowmapTexture));
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
//            Debug.Log(renderingData.cameraData.camera.name);            
            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            using (new ProfilingScope(cmd, m_ProfilingSampler))
            {
                // TODO: move-out update.
                Shader.SetGlobalFloat("_ShadowBias", 0.0f);
                Shader.SetGlobalFloat("_DepthSlopeBias", -0.005f);
                Shader.SetGlobalFloat("_DepthBias", 0.0f);
                Shader.SetGlobalColor("_TestColor", new Color(0.8f,0,0,1));
                Shader.SetGlobalMatrix("POSM_MATRIX_V", m_ShadowCamera.worldToCameraMatrix);
                var matrix = GL.GetGPUProjectionMatrix(m_ShadowCamera.projectionMatrix, false) * m_ShadowCamera.worldToCameraMatrix;
                Shader.SetGlobalMatrix("POSM_MATRIX_VP", matrix);                
                Shader.SetGlobalVector("posm_Parameters", new Vector4(1, 1000, 0.00098f, 0.00391f));
                Shader.SetGlobalVector("posm_ShadowCamera_Parameter", new Vector4(0.01f, 1.70942f, 0.58844f, -0.00588f));

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

                Shader.SetGlobalTexture(m_NN4Shadowmap.id, m_NN4ShadowmapTexture);                
            }
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }

        /// Cleanup any allocated resources that were created during the execution of this render pass.
        public override void FrameCleanup(CommandBuffer cmd)
        {
            if (cmd == null)
                throw new ArgumentNullException("cmd");

            if (m_NN4ShadowmapTexture)
            {
                RenderTexture.ReleaseTemporary(m_NN4ShadowmapTexture);
                m_NN4ShadowmapTexture = null;
            }
        }
    }
}


