Shader "Hidden/GameOfLife"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			sampler2D _MainTex;
			float2 _Resolution;

			float HowManyAround (sampler2D bitmap, float2 p, float2 resolution)
			{
				int count = 0;
				for (int x = -1; x <= 1; ++x) {
					for (int y = -1; y <= 1; ++y) {
						if ((x == 0 && y == 0) == false) {
							count += step(0.5, tex2D(_MainTex, p + float2(x, y) / resolution).r);
						}
					}
				}
				return count;
			}

			fixed4 frag (v2f_img i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				float howManyAround = HowManyAround(_MainTex, i.uv, _Resolution);
				float isAlive = step(0.5, col.r);
				if (isAlive) {
					if (howManyAround < 2 || howManyAround > 3) {
						col.rgb = float3(0,0,0);
					} else {
						col.rgb = float3(1,1,1);
					}
				} else {
					if (howManyAround == 3) {
						col.rgb = float3(1,1,1);
					}
				}
				return col;
			}
			ENDCG
		}
	}
}
