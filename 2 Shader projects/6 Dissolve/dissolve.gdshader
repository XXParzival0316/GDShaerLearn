shader_type canvas_item;

uniform sampler2D noise;
uniform float progress: hint_range(0.0, 1.0);
uniform float gradient_progress: hint_range(0.0, 1.0);
uniform vec3 dissolve_color: source_color;

void fragment() {
	float noise_alpha = texture(noise, UV).r;
	COLOR.a = step(progress, noise_alpha);
	COLOR.a += smoothstep(noise_alpha, 0.0, gradient_progress);	
	COLOR.rgb = step(progress, noise_alpha) < 1.0 ? dissolve_color : COLOR.rgb;
	COLOR.a = min(COLOR.a, texture(TEXTURE, UV).a);
	
}

