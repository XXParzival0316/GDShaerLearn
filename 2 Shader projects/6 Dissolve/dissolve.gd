extends Node2D

func _ready() -> void:
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property($Sprite2D.material, 'shader_parameter/progress', 1.0 ,0.8).from(0)
	tween.tween_property($Sprite2D.material, 'shader_parameter/gradient_progress', 1.0 ,1.3).from(0)
	
