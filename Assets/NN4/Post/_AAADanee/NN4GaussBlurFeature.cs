using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;

public class NN4GaussBlurFeature : ScriptableRendererFeature
{
    [System.Serializable, ReloadGroup]
    public class NN4PostSettings
    { 
        public Material blurMat;
        public Material bloomMat;
        public Material characterMat;
    }
    private GaussBlurPass pass;
    public NN4PostSettings m_Settings;
    Shader blurShader;
    Shader bloomShader;
    Shader characterShader;

    Material blurMat;
    Material bloomMat;
    Material characterMat;
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        
        blurMat = m_Settings.blurMat;
        bloomMat = m_Settings.bloomMat;
        characterMat = m_Settings.characterMat;

        if(bloomMat == null || blurMat == null || characterMat == null)
            return;        
        // //if (blurShader == null)
        // blurShader = Shader.Find("NN4/HIDDEN/GaussBlur");

        // if (bloomShader == null)
        //     bloomShader = Shader.Find("NN4/HIDDEN/BloomDownSample");

        // if (characterShader == null)
        //     characterShader = Shader.Find("NN4/HIDDEN/ImageEffectCharacter");

        // //if (blurMat == null)
        //     blurMat = CoreUtils.CreateEngineMaterial(blurShader);

        // if (bloomMat == null)
        //     bloomMat = CoreUtils.CreateEngineMaterial(bloomShader);

        // if (characterMat == null)
        //     characterMat = CoreUtils.CreateEngineMaterial(characterShader);


        //主纹理
        var cameraColorTarget = renderer.cameraColorTarget;
        //image.texture = renderer.cameraColorTarget;

        //设置调用后处理pass
        pass.Setup(cameraColorTarget, blurMat,bloomMat,characterMat);

        //添加该Pass到渲染管线中
        renderer.EnqueuePass(pass);
    }

    public override void Create()
    {
        pass = new GaussBlurPass(m_Settings);
        pass.renderPassEvent = RenderPassEvent.AfterRenderingTransparents;
    }
    
    public class GaussBlurPass : ScriptableRenderPass
    {
        const string CommandBufferTag = "GaussBlur Pass";
        public NN4PostSettings m_Settings;   
        Material blurMat;
        Material bloomMat;
        Material characterMat;

        GaussBlurParms m_GaussBlurParms;

        RenderTargetIdentifier m_ColorAttachment;

        RenderTargetHandle rt1;
        RenderTargetHandle rt2;
        RenderTargetHandle rt3;
        RenderTargetHandle bloomRt;
        RenderTargetHandle oriRt;

        int texWidth = 270;
        int texHeight = 480;

        Texture curveTex;

        const string texPath = "ShaderTex";

        public GaussBlurPass(NN4PostSettings settings)
        {
            m_Settings = settings;
            rt1.Init("tempRt1");
            rt2.Init("tempRt2");
            rt3.Init("tempRt3");
            bloomRt.Init("bloomRT");
            oriRt.Init("tempRt4");
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            var stack = VolumeManager.instance.stack;
            m_GaussBlurParms = stack.GetComponent<GaussBlurParms>();

            var cmd = CommandBufferPool.Get(CommandBufferTag);

            Render(cmd, ref renderingData);

            //执行命令缓冲
            context.ExecuteCommandBuffer(cmd);
            //释放命令缓冲
            CommandBufferPool.Release(cmd);
        }

        public void Setup(RenderTargetIdentifier _ColorAttachment, Material blurMat,Material bloomMat,Material characterMat)
        {
            this.m_ColorAttachment = _ColorAttachment;
            this.blurMat = blurMat;
            this.bloomMat = bloomMat;
            this.characterMat = characterMat;
        }

        //近似于OnRenderImage
        void Render(CommandBuffer cmd, ref RenderingData renderingData)
        {
            if (m_GaussBlurParms.IsActive() && !renderingData.cameraData.isSceneViewCamera && Application.isPlaying)
            {
                cmd.GetTemporaryRT(oriRt.id, 1080,1920,0, FilterMode.Bilinear);
                Blit(cmd, m_ColorAttachment, oriRt.Identifier());
                RenderTextureDescriptor postEffectDesc = new RenderTextureDescriptor(texWidth,texHeight,RenderTextureFormat.ARGB32,0);
                cmd.GetTemporaryRT(rt1.id, postEffectDesc, FilterMode.Bilinear);
                cmd.GetTemporaryRT(rt2.id, postEffectDesc, FilterMode.Bilinear);
                cmd.GetTemporaryRT(rt3.id, postEffectDesc, FilterMode.Bilinear);

                blurMat.SetFloat("_BloomThreshold", m_GaussBlurParms.bloomThreshold.value);
                Blit(cmd, m_ColorAttachment, rt1.Identifier(), bloomMat, 0);
                blurMat.SetVector("_BlurRadius", m_GaussBlurParms.blurRadius.value);
                Blit(cmd, rt1.Identifier(), rt2.Identifier(), blurMat, 0);
                Blit(cmd, rt2.Identifier(), rt1.Identifier(), blurMat, 1);
                Blit(cmd, rt1.Identifier(), rt3.Identifier());

                RenderTargetHandle[] tempRender = new RenderTargetHandle[3];
                for (int i = 0; i < 3; i++)
                {
                    int count = (int)Mathf.Pow(2.0f, (float)(i + 1));
                    postEffectDesc = new RenderTextureDescriptor(texWidth / count, texHeight / count, RenderTextureFormat.ARGB32, 0);
                    cmd.ReleaseTemporaryRT(rt2.id);
                    cmd.GetTemporaryRT(rt2.id, postEffectDesc, FilterMode.Bilinear);
                    Blit(cmd, rt1.Identifier(), rt2.Identifier(), bloomMat, 1);
                    cmd.ReleaseTemporaryRT(rt1.id);
                    cmd.GetTemporaryRT(rt1.id, postEffectDesc, FilterMode.Bilinear);
                    Blit(cmd, rt2.Identifier(), rt1.Identifier(), blurMat, 0);
                    Blit(cmd, rt1.Identifier(), rt2.Identifier(), blurMat, 1);
                    cmd.ReleaseTemporaryRT(tempRender[i].id);
                    tempRender[i] = rt2;                
                    cmd.SetGlobalTexture("_Tex" + Mathf.Pow(2, i + 3), tempRender[i].Identifier());
                    Blit(cmd, rt2.Identifier(), rt1.Identifier());
                }

                cmd.GetTemporaryRT(bloomRt.id, texWidth, texHeight, 0, FilterMode.Bilinear);
                Blit(cmd, rt3.Identifier(), bloomRt.Identifier(), blurMat, 2);
                cmd.SetGlobalTexture("_BloomTex", bloomRt.Identifier());
                if (curveTex == null)
                {
                    curveTex = Resources.Load(texPath + "/_CurveTex") as Texture;
                }
                characterMat.SetTexture("_CurveTex", curveTex);
                Blit(cmd, oriRt.Identifier(), m_ColorAttachment, characterMat);
            }
        }
        public override void FrameCleanup(CommandBuffer cmd)
        {
            cmd.ReleaseTemporaryRT(rt1.id);
            cmd.ReleaseTemporaryRT(rt2.id);
            cmd.ReleaseTemporaryRT(rt3.id);
            cmd.ReleaseTemporaryRT(oriRt.id);
            cmd.ReleaseTemporaryRT(bloomRt.id);
        }
    }

}
