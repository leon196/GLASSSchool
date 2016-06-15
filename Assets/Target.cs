using UnityEngine;
using System.Collections;

public class Target : MonoBehaviour {

	public Material material;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		material.SetVector("_Target", transform.position);
	}
}
