// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "NewMiniGame/OutLineShader"
{
	Properties
	{
		_EdgeColor("Edge Color",Color)=(0,0,0,1)
		_EdgeOnly("Outline width", Range(-.002, 0.3)) = .005
		_EdgeOnlyMinus("Outline width Minus", Range(-.3, -0.002)) = -.005
		_EdgeFocus("Edge Focus",Vector)=(0,0,0,0)
	}
	SubShader
	{
		Tags{"Queue"="Geometry-10"}
			CGINCLUDE
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag
			fixed _EdgeOnly;
			fixed4 _EdgeColor;
			fixed _EdgeOnlyMinus;
			fixed4 _EdgeFocus; 
			struct Vert
				{
					fixed4 Vertex:POSITION;
					fixed3 Normal:NORMAL;					
				};	

			fixed4 frag():SV_Target{
				return _EdgeColor;
			}	
			ENDCG
		Pass
		{

			Name"OutLine"	
			Cull  Front
			CGPROGRAM	
			fixed4 vert(Vert v):SV_POSITION{
				fixed3 n=mul((float3x3)UNITY_MATRIX_MV,v.Normal);
				fixed4 s=mul(UNITY_MATRIX_MV,v.Vertex);
				n.z=-0.5;
				s.xyz += (normalize(n)*_EdgeOnly);
				s=mul(UNITY_MATRIX_P,s);
				return s;
			}
			ENDCG

		}
		Pass{
			Name"OutLine2"
			Cull  Back 	
			CGPROGRAM

			fixed4 vert(Vert v):SV_POSITION{
				fixed3 n=mul((float3x3)UNITY_MATRIX_MV,v.Normal);
				fixed4 s=mul(UNITY_MATRIX_MV,v.Vertex);

				fixed3 viewDir =normalize(_EdgeFocus.xyz-mul(unity_ObjectToWorld,v.Vertex).xyz);
				fixed3 wn=mul(unity_ObjectToWorld,v.Normal);
				fixed f = pow(1-saturate(dot(viewDir ,wn)),1);
				fixed x = pow(saturate(dot(viewDir, wn)), 1);
				fixed a=_EdgeOnly*f + _EdgeOnlyMinus * x;
				//n.z=-0.5;
				s.xyz += (normalize(n)*a);
				s=mul(UNITY_MATRIX_P,s);
				return s;
			}
			ENDCG
		}
	}
}
