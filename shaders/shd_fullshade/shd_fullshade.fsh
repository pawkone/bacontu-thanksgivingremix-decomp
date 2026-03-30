varying vec2 v_vTexcoord;
varying vec4 v_vColour;
// THE COLORS...
uniform vec3 darkest;
uniform vec3 lightest;
//full color shader woeie wow wow FUCK FUCLK FUCK
void main()
{
	// I dont know what im doing XD
	vec4 tex = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord); //texture and its color
	vec3 dark = darkest;
	vec3 light = lightest;
	dark = dark;
	light = light;
	if (distance(tex, vec4(0, 0, 0, tex.a)) <= 0.2) { //distance to black, if its close dark color
		gl_FragColor.rgb = vec3(dark.r, dark.g, dark.b);
	}
	else {
		gl_FragColor.rgb = vec3(light.r, light.g, light.b); // if not, light color
	}
	gl_FragColor.a = tex.a;
}