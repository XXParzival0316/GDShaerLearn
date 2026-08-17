shader_type canvas_item;

uniform float static : hint_range(0.0, 1.0) = 0.5;
uniform float grid_size : hint_range(0.0, 100.0) = 10.;

float random(vec2 uv){
	// how to create random values??
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 4375.5453123);

}

void fragment() {
	// 雪花噪点效果
	// float nosie = random(UV + vec2(TIME * 0.0001));
	// COLOR.rgb = mix(COLOR.rgb,vec3(nosie),static);
	COLOR.a = 1.;
	vec2 grid_uv = floor(UV * grid_size);
	float r = random(grid_uv);
	float g = random(grid_uv + vec2(1.));
	float b = random(grid_uv + vec2(2.));
	COLOR.rgb = vec3(r,g,b);
}

