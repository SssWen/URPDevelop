using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable, VolumeComponentMenu("Addition-Post-processing/GaussBlurParms")]
public class GaussBlurParms : VolumeComponent,IPostProcessComponent
{
    public Vector2Parameter blurRadius = new Vector2Parameter(new Vector2(1.0f,1.77778f));

    public FloatParameter bloomThreshold = new FloatParameter(2.0f);

    public bool IsActive()
    {
        return blurRadius.value.x > 0;
    }

    public bool IsTileCompatible()
    {
        return false;
    }
}
