using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TestShadowmap : MonoBehaviour
{
    private RawImage showShadowmap;
    // Start is called before the first frame update
    void Start()
    {
        showShadowmap = GetComponent<RawImage>();
    }

    // Update is called once per frame
    void Update()
    {
        showShadowmap.texture = Shader.GetGlobalTexture("posm_ShadowMap");
    }
}
