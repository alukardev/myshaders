Shader "Custom/Scroll"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
		_ScrollXSpeed("X Speed", Range(0, 10)) = 2
		_ScrollYSpeed("Y Speed", Range(0, 10)) = 2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM

        #pragma surface surf Lambert fullforwardshadows
        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
        };

		fixed4 _Color;
		sampler2D _MainTex;
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;

        void surf (Input IN, inout SurfaceOutput o)
        {
			fixed2 scrolledUV = IN.uv_MainTex;

			fixed _xScrollValue = _ScrollXSpeed * _Time;
			fixed _yScrollValue = _ScrollYSpeed * _Time;

			scrolledUV += fixed2(_xScrollValue, _yScrollValue);
			fixed4 c = tex2D(_MainTex, scrolledUV);

            o.Albedo = c.rgb * _Color.rgb;
            o.Alpha = _Color.a;
        }
        ENDCG
    }
    FallBack "Mobile/Diffuse"
}
