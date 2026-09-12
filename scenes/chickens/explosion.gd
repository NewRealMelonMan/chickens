extends Node2D

var explode_finished:bool

func _ready():
	$boom.visible = false
	$fog.visible = false
	$explode.play("boom")
	$fog.play("default")

func _on_explode_animation_finished() -> void:
	$explode.queue_free()
	explode_finished = true

func _process(delta: float) -> void:
	if explode_finished == true:
		$fog.modulate.a -= 0.001
	if $fog.modulate.a  <= 0:
		$boom.modulate.a -= 0.001
	if $boom.modulate.a  <= 0:
		queue_free()


func _on_explode_frame_changed() -> void:
	if $explode.frame >= 3:
		$boom.visible = true
		$fog.visible = true
