extends "res://scenes/chickens/chiken.gd"

func _ready() -> void:
	super()
	egg_scene = preload("res://scenes/eggs/egg_golden.tscn")
	do_shine = true
