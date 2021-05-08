using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class NN4DepthFeatures : ScriptableRendererFeature
{
    class NN4DepthPass : ScriptableRenderPass
    {
        private RenderTargetHandle destination { get; set; }

        private Material depthMaterial = null;
        private FilteringSettings m_FilteringSettings;
        ShaderTagId m_ShaderTagId = new ShaderTagId("DepthOnly");

        RenderTexture m_NN4ShadowmapTexture;
        public NN4DepthPass(RenderQueueRange renderQueueRange, LayerMask layerMask, Material material)
        {
            m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
            this.depthMaterial = material;
        }

        public void Setup(RenderTargetHandle destination)
        {
            this.destination = destination;
        }
//        public void Setup(
//            RenderTextureDescriptor baseDescriptor,
//            RenderTargetHandle depthAttachmentHandle)
//        {
//            this.depthAttachmentHandle = depthAttachmentHandle;
//            baseDescriptor.colorFormat = RenderTextureFormat.Depth;
//            baseDescriptor.depthBufferBits = kDepthBufferBits;
//
//            // Depth-Only pass don't use MSAA
//            baseDescriptor.msaaSamples = 1;
//            descriptor = baseDescriptor;
//        }
        // This method is called before executing the render pass.
        // It can be used to configure render targets and their clear state. Also to create temporary render target textures.
        // When empty this render pass will render to the active camera render target.
        // You should never call CommandBuffer.SetRenderTarget. Instead call <c>ConfigureTarget</c> and <c>ConfigureClear</c>.
        // The render pipeline will ensure target setup and clearing happens in an performance manner.
        /// <summary>
        /// 执行pass的时候,都执行一次配置.
        /// </summary>
        /// <param name="cmd"></param>
        /// <param name="cameraTextureDescriptor"></param>
        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)

        {
            m_NN4ShadowmapTexture = new RenderTexture(1024, 1024, 24, RenderTextureFormat.RHalf);
            RenderTextureDescriptor descriptor = cameraTextureDescriptor;
            descriptor.depthBufferBits = 24;
            descriptor.colorFormat = RenderTextureFormat.RHalf;

            cmd.GetTemporaryRT(destination.id, descriptor, FilterMode.Bilinear);

            //  ConfigureTarget Instead CommandBuffer.SetRenderTarget();
            // TODO: 还需要找到Command的指定位置
            ConfigureTarget(new RenderTargetIdentifier(m_NN4ShadowmapTexture));
            ConfigureClear(ClearFlag.All, Color.black);
        }

        // Here you can implement the rendering logic.
        // Use <c>ScriptableRenderContext</c> to issue drawing commands or execute command buffers
        // https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html
        // You don't have to call ScriptableRenderContext.submit, the render pipeline will call it at specific points in the pipeline.
        /// <summary>
        /// 具体按顺序执行pass
        /// </summary>
        /// <param name="context"></param>
        /// <param name="renderingData"></param>
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            CommandBuffer cmd = CommandBufferPool.Get("NN4DepthPass Prepass");

            using (new ProfilingSample(cmd, "NN4DepthPass Prepass"))
            {
                context.ExecuteCommandBuffer(cmd);
                cmd.Clear();

                var sortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
                var drawSettings = CreateDrawingSettings(m_ShaderTagId, ref renderingData, sortFlags);
                drawSettings.perObjectData = PerObjectData.None;

                ref CameraData cameraData = ref renderingData.cameraData;
                //Camera camera = cameraData.camera;

                drawSettings.overrideMaterial = depthMaterial;


                context.DrawRenderers(renderingData.cullResults, ref drawSettings,
                    ref m_FilteringSettings);

                cmd.SetGlobalTexture("posm_ShadowMap", destination.id);
            }
            
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }

        /// Cleanup any allocated resources that were created during the execution of this render pass.
        public override void FrameCleanup(CommandBuffer cmd)
        {
            if (destination != RenderTargetHandle.CameraTarget)
            {
                cmd.ReleaseTemporaryRT(destination.id);
                destination = RenderTargetHandle.CameraTarget;
            }
        }
    }

    NN4DepthPass nn4DepthPass;
    RenderTargetHandle shadowmapTexture;
    Material depthMaterial;

    /// <summary>
    /// 创建Assets的时候调用
    /// </summary>
    public override void Create()
    {
        depthMaterial = CoreUtils.CreateEngineMaterial("NN4/ShadowCaster");
        nn4DepthPass = new NN4DepthPass(RenderQueueRange.opaque, -1, depthMaterial);
        nn4DepthPass.renderPassEvent = RenderPassEvent.BeforeRenderingShadows;
        shadowmapTexture.Init("posm_ShadowMap");
    }

    // Here you can inject one or multiple render passes in the renderer.
    // This method is called when setting up the renderer once per-camera.

    /// <summary>
    /// 每个相机都调用,每帧都渲染.插入pass,设置等
    /// </summary>
    /// <param name="renderer"></param>
    /// <param name="renderingData"></param>
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        
        nn4DepthPass.Setup(shadowmapTexture);
        renderer.EnqueuePass(nn4DepthPass);
    }
}


