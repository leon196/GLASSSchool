using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class PostProcessing : MonoBehaviour 
{
	Material material;

	void Awake () 
	{
		material = new Material( Shader.Find("Hidden/PostProcessing") );
	}

	void OnRenderImage (RenderTexture source, RenderTexture destination) 
	{
		Graphics.Blit (source, destination, material);
	}
}