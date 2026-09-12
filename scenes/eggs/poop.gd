extends "res://scenes/eggs/egg.gd"

func _ready() -> void:
	super()
	price = -1
	$AnimatedSprite2D.play("idle")
