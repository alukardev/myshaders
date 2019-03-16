﻿Shader "Custom/BaseWithNormal"
{
    Properties
    {
		_Color("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalTex("Normal Map", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert noforwardadd

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
			o.Normal = UnpackNormal(tex2D (_NormalTex, IN.uv_MainTex));
        }
        ENDCG
    }
    Fallback "Mobile/VertexLit"
}
