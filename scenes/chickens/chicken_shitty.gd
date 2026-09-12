extends "res://scenes/chickens/chiken.gd"

func _ready() -> void:
	super()
	$Sprite2D.visible = false
	egg_scene = preload("res://scenes/eggs/egg_shit.tscn")
	$AnimatedSprite2D2.frame = randi_range(0,4)

func _process(delta: float) -> void:
	super(delta)
	$AnimatedSprite2D2.scale = $Sprite2D.scale
	$AnimatedSprite2D2.rotation = $Sprite2D.rotation
	$AnimatedSprite2D2.position = $Sprite2D.position
