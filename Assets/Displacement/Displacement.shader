Shader "Unlit/Displacement"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Speed ("Speed", Float) = 100
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Speed;
			float3 _Target;
			
			v2f vert (appdata_full v)
			{
				v2f o;

				float4 vertex = mul(_Object2World, v.vertex);
				float wave = 10.0 * distance(_Target, vertex.xyz);

				float displacement = sin(-_Time.x * _Speed + wave) * 0.1;
				vertex.xyz += v.normal * displacement;
				vertex = mul(_World2Object, vertex);

				o.vertex = mul(UNITY_MATRIX_MVP, vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
