shader_type canvas_item;

const vec2 center = vec2(0.5);
// 圆大小
uniform float radius: hint_range(0.0, 1.0) = 0.5;
// 渐变宽度
uniform float width: hint_range(0.0, 1.0) = 0.5;
//高光中心区域
uniform vec2 highlight_center;
uniform float highlight_alph: hint_range(0.0, 1.0) = 0.5;
// 颜色
uniform vec3 main_color: source_color;
uniform vec3 highlithg_color: source_color;
uniform float glow: hint_range(0.0, 1.0) = 0.5;
//噪点
uniform sampler2D noise:repeat_enable;

void vertex(){
	// normalize:归一化 精确控制伸缩大小
	VERTEX += normalize(VERTEX) * 50. * sin(TIME) * 0.1;
}

void fragment() {
	// main shape 主体图形
	float circle_main = step(distance(UV,center),radius);
	float circle_inner = smoothstep(width * 0.5,1,distance(UV,center));
	float main_shape = circle_main * circle_inner;
	
	// highlight shape 高光
	float highlight_shape = pow(1. - distance(highlight_center,UV),3.) * highlight_alph * main_shape;
	
	// colors 色彩配置 混合数值
	vec3 color = main_color * main_shape + highlight_shape * highlithg_color;
	color *= vec3(1. + glow * 5.);
	
	// texture 动态噪点
	float texture_alpha = texture(noise,UV + vec2(TIME * 0.1,0.)).r * 3.;
	
	COLOR.a = (main_shape + highlight_shape) * texture_alpha;
	COLOR.rgb = color;
}
