using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class TestCustomRenderPassFeature : ScriptableRendererFeature
{
    class CustomRenderPass : ScriptableRenderPass
    {
        CustomRPSettings _CustomRPSettings;
        RenderTargetHandle _TemporaryColorTexture;

        private RenderTargetIdentifier _Source;
        private RenderTargetHandle _Destination;

        public CustomRenderPass(CustomRPSettings settings)
        {
            _CustomRPSettings = settings;
        }

        public void Setup(RenderTargetIdentifier source, RenderTargetHandle destination)
        {
            _Source = source;
            _Destination = destination;
        }

        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
        {
            _TemporaryColorTexture.Init("_TemporaryColorTexture_NN");
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            CommandBuffer cmd = CommandBufferPool.Get("My Pass");

            if (_Destination == RenderTargetHandle.CameraTarget)
            {                
                cmd.GetTemporaryRT(_TemporaryColorTexture.id, renderingData.cameraData.cameraTargetDescriptor, FilterMode.Point);
                cmd.Blit(_Source, _TemporaryColorTexture.Identifier());
                cmd.Blit(_TemporaryColorTexture.Identifier(), _Source, _CustomRPSettings.m_Material);
            }
            else
            {                
                cmd.Blit(_Source, _Destination.Identifier(), _CustomRPSettings.m_Material, 0);
            }

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }

        public override void FrameCleanup(CommandBuffer cmd)
        {
            if (_Destination == RenderTargetHandle.CameraTarget)
            {
                cmd.ReleaseTemporaryRT(_TemporaryColorTexture.id);
            }
        }
    }

    [System.Serializable]
    public class CustomRPSettings
    {
        public Material m_Material;
    }

    public CustomRPSettings m_CustomRPSettings = new CustomRPSettings();
    CustomRenderPass _ScriptablePass;

    public override void Create()
    {
        _ScriptablePass = new CustomRenderPass(m_CustomRPSettings);

        _ScriptablePass.renderPassEvent = RenderPassEvent.AfterRenderingOpaques;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        _ScriptablePass.Setup(renderer.cameraColorTarget, RenderTargetHandle.CameraTarget);
        renderer.EnqueuePass(_ScriptablePass);
    }
}