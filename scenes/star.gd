extends Node2D

func _process(delta: float) -> void:
	position.y -= delta *100
	modulate.a -=0.01
	if modulate.a <=0:
		queue_free()
