shader_type canvas_item;

uniform vec4 colors[16]: source_color;
uniform vec3 gray_weights = vec3(.299,.587,.114); // NTSC conversion weights
uniform float vibrance: hint_range(0.0, 1.0);

int get_index(float value){
	return int(round(value * 20.));
}

void fragment() {
	COLOR = colors[get_index(COLOR.r)] * COLOR.a;
	float luminance = dot(COLOR.rgb,gray_weights);
	COLOR.rgb = mix(vec3(luminance),COLOR.rgb,vibrance * 2.0);
}

