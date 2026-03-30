//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D tex_setColors;
uniform vec4 tex_colorsUV;
uniform float tex_height;
void main()
{
	vec4 baseColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	for (float i = tex_colorsUV.y; i <= tex_colorsUV.w; i += tex_height)
	{
		vec2 colorPos = vec2(tex_colorsUV.x, i);
		vec4 color = texture2D(tex_setColors, colorPos);
		if (color == baseColor) {
			gl_FragColor = vec4(1.0);
			break;
		}
	}
}