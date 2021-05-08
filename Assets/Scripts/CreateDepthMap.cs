using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.UI;

public class CreateDepthMap : MonoBehaviour
{
    public Renderer[] meshRenderer;    
    private Material depthMat;
    private Camera shadowCamera;
    public Shader depthShader;            
    private CommandBuffer depthCB;
    CameraEvent cameraEvent = CameraEvent.BeforeForwardOpaque;
    private RenderTexture depthTexture;
    public RawImage showDepthTexture;
    void Awake()
    {        
        depthMat = new Material(depthShader);
        shadowCamera = this.GetComponent<Camera>();
    }
    private void OnEnable()
    {
        CreateDepthCommandBuffer();
    }

    private void CreateDepthCommandBuffer()
    {
        depthCB = new CommandBuffer();
        depthCB.name = "Depth Buffer";

        depthTexture = new RenderTexture(1024, 1024, 24, RenderTextureFormat.RHalf);

        RenderTargetIdentifier renderDepthID = new RenderTargetIdentifier(depthTexture);
        depthCB.SetRenderTarget(renderDepthID);
        depthCB.ClearRenderTarget(true, true, Color.black, 1f);
        for(int i=0; i<meshRenderer.Length; i++ )
        {
            depthCB.DrawRenderer(meshRenderer[i], depthMat);    
        }        
        
        

        shadowCamera.AddCommandBuffer(cameraEvent, depthCB);

        Shader.SetGlobalFloat("_ShadowBias",0.0f);
        Shader.SetGlobalFloat("_DepthSlopeBias",-0.005f);
        Shader.SetGlobalFloat("_DepthBias",0.0f);

        Shader.SetGlobalMatrix("POSM_MATRIX_V", shadowCamera.worldToCameraMatrix);
        var matrix = GL.GetGPUProjectionMatrix(shadowCamera.projectionMatrix, false) * shadowCamera.worldToCameraMatrix;
        Shader.SetGlobalMatrix("POSM_MATRIX_VP", matrix);
        Shader.SetGlobalTexture("posm_ShadowMap", depthTexture);
        // posm_SampleBias = 0.001f
        Shader.SetGlobalVector("posm_Parameters", new Vector4(1, 1000, 0.00098f, 0.00391f));
        Shader.SetGlobalVector("posm_ShadowCamera_Parameter", new Vector4(0.01f, 1.70942f, 0.58844f, -0.00588f));

        if(showDepthTexture!=null)
            showDepthTexture.texture = depthTexture;
    }
  


    private void OnDisable()
    {
        shadowCamera.RemoveCommandBuffer(cameraEvent, depthCB);
    }

    void Update()
    {
        Shader.SetGlobalMatrix("POSM_MATRIX_V", shadowCamera.worldToCameraMatrix);
        var matrix = GL.GetGPUProjectionMatrix(shadowCamera.projectionMatrix, false) * shadowCamera.worldToCameraMatrix;
        Shader.SetGlobalMatrix("POSM_MATRIX_VP", matrix);
         Shader.SetGlobalTexture("posm_ShadowMap", depthTexture);
    }

}