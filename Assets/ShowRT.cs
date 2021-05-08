using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowRT : MonoBehaviour
{
    public RawImage showShadowmap;
    // Start is called before the first frame update
    void Start()
    {
        showShadowmap = GetComponent<RawImage>();
    }

    // Update is called once per frame
    void Update()
    {
//        showShadowmap.texture  = Shader.GetGlobalTexture( Shader.PropertyToID("_ZorroShadowmapTexture"));
        //        showShadowmap.texture = Shader.GetGlobalTexture("_AdditionalLightsShadowmapTexture");
        //        showShadowmap.texture = Shader.GetGlobalTexture("_CameraDepthAttachment");
        //        showShadowmap.texture = Shader.GetGlobalTexture("ShadowMap NN");
        //        showShadowmap.texture = Shader.GetGlobalTexture("_CameraColorTexture"); // 1 
        showShadowmap.texture = Shader.GetGlobalTexture("_ZorroShadowmapTexture");
    }
}
