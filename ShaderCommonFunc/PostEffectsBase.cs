using UnityEngine;

namespace Pathea
{
    namespace MiniGameNs
    {
        public class PostEffectsBase : MonoBehaviour
        {
            protected void CheckResourceces()
            {
                bool isSupported = CheckSupport();
                if (!isSupported)
                {
                    NotSupported();
                }
            }

            protected void NotSupported()
            {
                enabled = false;
            }

            protected bool CheckSupport()
            {
                if (!SystemInfo.supportsImageEffects)
                {
                    Debug.LogError("this platform does not support image effect");
                    return false;
                }
                return true;
            }

            protected Material CheckShaderAndCreateMaterial(Shader shader, Material material)
            {
                if (shader == null)
                {
                    return null;
                }
                if (shader.isSupported && material && material.shader == shader)
                {
                    return material;
                }
                if (!shader.isSupported)
                {
                    return null;
                }
                else
                {
                    material = new Material(shader);
                    material.hideFlags = HideFlags.DontSave;
                    if (material)
                    {
                        return material;
                    }
                    else
                    {
                        return null;
                    }
                }
            }

            protected void Start()
            {
                CheckResourceces();
            }
        }
    }
}