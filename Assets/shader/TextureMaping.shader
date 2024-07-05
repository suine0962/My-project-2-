Shader "Unlit/TextureMaping"
{
	Properties
	{
		_MainTex("Texture",2D) = "pikopiko_hummer.png"{}
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// #pragma multi_compile_fog

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv :TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv :TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed _Color;

			fixed4 frag(v2f i) : SV_Target
			{
				//TextureMaping
				float2 tiling = _MainTex_ST.xy;
				float2 offset = _MainTex_ST.zw;
				fixed4 col = tex2D(_MainTex, i.uv * tiling + offset);
				return col;
			}
			ENDCG
	    }  
	}
}


