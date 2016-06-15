Shader "Hidden/PostProcessing"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			
			sampler2D _MainTex;

			fixed4 frag (v2f_img i) : SV_Target
			{
				float2 uv = i.uv;
				
				float oscillation = sin(_Time.x * 10.0) * 0.5 + 0.5;
				float size = 8.0 + 64.0 * oscillation;
				
				// pixelize
				uv = floor(uv * size) / size;

				fixed4 col = tex2D(_MainTex, uv);

				return col;
			}
			ENDCG
		}
	}
}
