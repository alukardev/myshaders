Shader "Custom/Silhouette"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_DotProduct("Rim effect", Range(-1,1)) = 0.25;
    }
    SubShader
    {
        Tags 
		{ 
			"RenderType"="Transparent"
			"IgnoreProjector" = "True"
			"Queue" = "Transparent"
		}
        LOD 200

        CGPROGRAM

        #pragma surface surf Lambert alpha:fade nolighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
			float3 worldNormal;
			float viewDir;
        };

        fixed4 _Color;
		float _DontProduct;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;

			float border = 1;

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
