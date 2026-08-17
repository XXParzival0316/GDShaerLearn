shader_type canvas_item;

uniform float width: hint_range(0.0, 1.0);
uniform float size: hint_range(0.0, 1.0) = 0.75;
uniform float blur: hint_range(0.0, 1.0) = 0.1;
uniform sampler2D fire: repeat_enable;
uniform float flicker: hint_range(0.0, 1.0);

uniform vec3 main_color: source_color;
uniform vec3 mid_color: source_color;
uniform vec3 inner_color : source_color;

void fragment() {
	// shape 衰减渐变椭圆
	vec2 uv = 2. * UV - 1.;
	float ellipse = length(vec2(uv.x * (2. - width),uv.y));
	float falloff =smoothstep(-0.6,0.5,uv.y);
	float shape = smoothstep(size,size - blur, ellipse) * falloff;

	// texture 带动画偏移噪点纹理
	// 利用时间移动采样点形成流动效果
	vec2 moving_uv = vec2(UV.x,UV.y + TIME * flicker);
	float fire_noise = texture(fire, moving_uv).r;

	// fire shape 划分火焰三层轮廓
	float fire_main_shape = step(0.3, shape * 0.3 + fire_noise * 0.3);
	float fire_mid_shape = step(0.4, shape * 0.3 + fire_noise * 0.4);
	float fire_inner_shape = step(0.5, shape * 0.3 + fire_noise * 0.5);
	COLOR.a = fire_main_shape;

	// colors 分离三层颜色遮罩
	float outer_mask = fire_main_shape - fire_mid_shape;
	float mid_mask = fire_mid_shape - fire_inner_shape;
	COLOR.a = fire_main_shape;
	// 色彩独立渲染 不会干扰其他层级
	COLOR.rgb = outer_mask * main_color + mid_mask * mid_color + fire_inner_shape * inner_color;
	
	
}

