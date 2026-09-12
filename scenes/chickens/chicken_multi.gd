extends "res://scenes/chickens/chiken.gd"

var egg_or_chick: int
@onready var chicken_egg = preload("res://scenes/chickens/chiken.tscn")
@onready var egg_egg = preload("res://scenes/eggs/egg.tscn")

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	if egg_create_timer - delta <= 0:
		egg_or_chick = randi_range(1, 5)
		if egg_or_chick == 1:
			egg_scene = chicken_egg
		else:
			egg_scene = egg_egg
	
	super(delta)
