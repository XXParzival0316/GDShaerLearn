shader_type canvas_item;

uniform float progress:hint_range(0.0, 1.0, 0.1);
uniform sampler2D test_texture;

void fragment() {
	float diagonal = (UV.x + UV.y)/2.0;
	COLOR.a *= step(progress,diagonal);
	//vec4 test = texture(test_texture,UV);
	//COLOR.rgb = test.xyz;
}
