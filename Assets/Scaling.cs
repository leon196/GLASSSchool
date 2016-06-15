using UnityEngine;
using System.Collections;

public class Scaling : MonoBehaviour {

	public float speed = 10f;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () 
	{
		Vector3 scale = transform.localScale;
		scale.y = 0.5f + Mathf.Sin(Time.time * speed) * 0.5f;
		transform.localScale = scale;
	}
}
