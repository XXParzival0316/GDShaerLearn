shader_type canvas_item;

uniform float progress:hint_range(0.0, 1.0, 0.1);

// 先执行顶点着色器
void vertex(){
	VERTEX += vec2(50,0) * step(progress,UV.y);
}

// 再执行片元着色器
void fragment(){
	float y_pos = step(progress,UV.y);
	COLOR.rgb = vec3(y_pos);
}