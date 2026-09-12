extends Node2D

var x_feather
var y_feather
var rotate 

func _ready() -> void:
	y_feather = [1, -1].pick_random()
	x_feather = [1, -1].pick_random()
	rotate = [1, -1].pick_random()

func _process(delta: float) -> void:
	position.x += delta * x_feather *100
	position.y += delta * y_feather *100
	rotation_degrees += rotate
	modulate.a -= delta
	if modulate.a < 0:
		queue_free()
