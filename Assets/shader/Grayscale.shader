Shader "Unlit/Grayscale"
{
	Properties
	{
		_MainTex("MainTex",2D) = "white"{}
	}

	SubShader
	{

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

			fixed4 frag(v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex,i.uv);
				//fixed l = (col.r + col.g + col.b) / 3;
				fixed sepia = 0;
				fixed grayScale = col.r*0.299 + col.g*0.587 + col.b*0.114 ;
				return fixed4(grayScale + sepia, grayScale,grayScale - sepia,1);
			}
			ENDCG
		}	
	}
}
