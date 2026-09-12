extends "res://scenes/eggs/egg.gd"

func _ready() -> void:
	super()
	price = 256
	$AnimatedSprite2D.play("idle")
