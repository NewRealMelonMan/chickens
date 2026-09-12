extends "res://scenes/chickens/chiken.gd"

func prepare_to_move():
	super()
	if point_to_walk_to.x> position.x:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
