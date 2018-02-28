using System.Collections.Generic;
using UnityEngine;

namespace Pathea.MiniGameNs
{
    public class GameobjectOutline : MonoBehaviour
    {
        [SerializeField]
        private Material outLinematerial;
        [SerializeField]
        private Transform focusView;
        private Material outLineTempMaterial;

        private List<Material> materials;
        private Renderer render;
        private void OnEnable()
        {
            if (materials == null)
            {
                materials = new List<Material>();
            }
            materials.Clear();
            if (render == null)
            {
                render = GetComponent<Renderer>();
            }
            materials.AddRange(render.materials);
            if (outLineTempMaterial==null)
            {
                outLineTempMaterial = new Material(outLinematerial);
                outLineTempMaterial.SetVector("_EdgeFocus", new Vector4(focusView.position.x, focusView.position.y, focusView.position.z, 0));
            }
            materials.Add(outLineTempMaterial);
            render.materials = materials.ToArray();
        }
        private void OnDisable()
        {
            if (render == null)
            {
                render = GetComponent<Renderer>();
            }
            if (materials == null)
            {
                return;
            }
            materials.Remove(outLineTempMaterial);
            render.materials = materials.ToArray();
        }
    }
}