extends "res://scenes/eggs/egg.gd"

func _ready() -> void:
	super()
	price = 0
	$Sprite2D.queue_free()
	egg_texture=$AnimatedSprite2D
	$AnimatedSprite2D.play("idle")
