shader_type canvas_item;

uniform float center_size: hint_range(0.0, 1.0) = 0.772;
// 圆环自定义变量
uniform float circle_distance:hint_range(0.0, 1.0) = 0.5;
uniform float circle_width:hint_range(0.0, 1.0) = 0.5;
// 线条自定义变量
uniform float crosshair_distance:hint_range(0.0, 1.0) = 0.25;
uniform float crosshair_length: hint_range(0.0, 1.0) = 0.5;
uniform	 float crosshair_width:hint_range(0.0, 1.0) = 0.5;

float create_circles(vec2 uv){
	// 定义中心圆 center_size * 0.1 为了圆形限制大小
	float circle = step(distance(uv,vec2(0.5)),center_size * 0.1);
	// 定义外圆
	float outer_circle = step(distance(uv,vec2(0.5)),circle_distance);
	// 定义内圆
	float inner_circle = step(distance(uv,vec2(0.5)),circle_distance - circle_width);
	// 十字判断哪些区域需要镂空
	float cross_cutout = min(step(distance(uv.x,0.5),0.1) + step(distance(uv.y,0.5),0.1),1.);
	// 镂空圆环: 外圆 - 内圆 - 镂空区域
	// max(a,b) 返回a,b中较大的值 镂空圆环中心部分会为 -1 为了显示中心点要中心部分数值要为0
	return circle + max((outer_circle - inner_circle - cross_cutout),0.);
}

float create_lines(vec2 uv){
	vec2 center_distance = vec2(0.5) + crosshair_distance;
	// 画出两端垂直宽线条(用来控制线条长度)  
	float h_width = step(distance(uv.x,center_distance.x),crosshair_length * 0.25)
					+ step(distance(1. - uv.x,center_distance.x),crosshair_length * 0.25);
	// 画出居中水平线条(用来控制线条宽度)
	float h_height = step(distance(uv.y,0.5),crosshair_width * 0.02);
	float v_height = step(distance(uv.y,center_distance.y),crosshair_length * 0.25)
					+ step(distance(1. - uv.y,center_distance.y),crosshair_length * 0.25);
	float v_width = step(distance(uv.x,0.5),crosshair_width * 0.02);
	//线条叠加部分形成水平线条准星 height * width
	return h_width * h_height + v_height * v_width;
}

void fragment() {
	COLOR.rgb = vec3(1);
	//COLOR.a = create_circles(UV);
	COLOR.a = create_lines(UV) + create_circles(UV);
	
}
