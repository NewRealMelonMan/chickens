extends Node2D

var is_transitioning := false

func _ready():
	$CanvasLayer/ColorRect.modulate.a = 0.0
	$CanvasLayer/ColorRect.z_index

func change_scene(path: String):
	if is_transitioning:
		return
	is_transitioning = true
	
	var tween = create_tween()
	tween.tween_property($CanvasLayer/ColorRect, "modulate:a", 1.0, 0.85)
	await tween.finished
	
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	
	var tween2 = create_tween()
	tween2.tween_property($CanvasLayer/ColorRect, "modulate:a", 0.0, 0.75)
	await tween2.finished
	
	is_transitioning = false
