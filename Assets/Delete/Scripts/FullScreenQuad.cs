using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class FullScreenQuad : ScriptableRendererFeature
{
    [System.Serializable]
    public struct FullScreenQuadSettings
    {
        public RenderPassEvent renderPassEvent;
        public Material material;
    }

    public FullScreenQuadSettings m_Settings;
    FullScreenQuadPass m_RenderQuadPass;


    public override void Create()
    {
        m_RenderQuadPass = new FullScreenQuadPass(m_Settings);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        //        m_RenderQuadPass.Setup(renderer.cameraColorTarget, RenderTargetHandle.CameraTarget);
//        m_RenderQuadPass.ConfigureTarget(renderer.cameraColorTarget);
        if (m_Settings.material != null)
            renderer.EnqueuePass(m_RenderQuadPass);
    }


    public class FullScreenQuadPass : ScriptableRenderPass
    {
        string m_ProfilerTag = "DrawFullScreenPass";

        FullScreenQuad.FullScreenQuadSettings m_Settings;
        List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

        private RenderTargetIdentifier _Source;
        private RenderTargetHandle _Destination;
        RenderTargetHandle _TemporaryColorTexture;

        public FullScreenQuadPass(FullScreenQuad.FullScreenQuadSettings settings)
        {
            renderPassEvent = settings.renderPassEvent; // Event.BeforeRenderingOpaques
            m_Settings = settings;            
        }
//        public void Setup(RenderTargetIdentifier source, RenderTargetHandle destination)
//        {
//            _Source = source;
//            _Destination = destination;
//        }
        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
        {
            _TemporaryColorTexture.Init("_TemporaryColorTexture_NN");
            cmd.GetTemporaryRT(_TemporaryColorTexture.id, cameraTextureDescriptor.width, cameraTextureDescriptor.height, 0, FilterMode.Bilinear, RenderTextureFormat.ARGB32);

//            ConfigureTarget(_TemporaryColorTexture.id);
//            ConfigureClear(ClearFlag.All, Color.black);

//            cmd.SetRenderTarget(_TemporaryColorTexture.id);
//            cmd.ClearRenderTarget(true, true, Color.white, 1f);
        }
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
//            Camera camera = renderingData.cameraData.camera;

            CommandBuffer cmd = CommandBufferPool.Get(m_ProfilerTag);
            cmd.name = "FullScreen";
//            cmd.SetRenderTarget(_TemporaryColorTexture.id);
//            cmd.ClearRenderTarget(true, true, Color.white, 1f);

            var sortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
            var drawSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortFlags);
            drawSettings.overrideMaterial = m_Settings.material;
            var filterSettings = new FilteringSettings();
            context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref filterSettings);
            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
}
