extends Node2D

func _ready() -> void:
	#$Icon.material.set_shader_parameter("ColorParameter",Color.CORNFLOWER_BLUE)
	# 补间动画
	var tween = create_tween()
	#tween.tween_property($Icon.material,'shader_parameter/ColorParameter',Color.CHARTREUSE,3.0)
	#tween.set_loops()
	# 控制圆环切割大小
	#tween.tween_property($Icon.material,"shader_parameter/Size",0.1,1)
	#tween.tween_property($Icon.material,"shader_parameter/Size",0.5,1)
	# 控制图标位置偏移量
	#tween.tween_property($Icon.material,"shader_parameter/Offset",Vector2(100,0),1)
	#tween.tween_property($Icon.material,"shader_parameter/Offset",Vector2.ZERO,1)
