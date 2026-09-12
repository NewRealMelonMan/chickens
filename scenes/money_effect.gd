extends Node2D

@onready var position_y_on_start = position.y

func _process(delta: float) -> void:
	position.y -= 1
	modulate.a -=0.01
	if modulate.a <= 0:
		queue_free()
