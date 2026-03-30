//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;
uniform float frequency;
uniform float amplitude;
void main()
{
	float sinVal = sin((gl_FragCoord.y + time) * frequency) * amplitude;
	float sinVal2 = cos((gl_FragCoord.x + time) * frequency) * amplitude;
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vec2( v_vTexcoord.x + sinVal, v_vTexcoord.y + sinVal2) );
}