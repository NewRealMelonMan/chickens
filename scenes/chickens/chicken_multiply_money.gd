extends "res://scenes/chickens/chiken.gd"

var body_entered:bool

func _ready():
	super()
	do_eggs = false
	$Sprite2D2.modulate.a = 0.75

func _process(delta: float) -> void:
	super(delta)
	$Sprite2D2.rotation_degrees +=0.05

func _on_searching_eggs_area_entered(area: Area2D) -> void:
	if area.is_in_group("eggs_area"):
		area.get_parent().price *=1.25

func _on_searching_eggs_area_exited(area: Area2D) -> void:
	if area.is_in_group("eggs_area") and !area.get_parent().goin_to_basket:
		area.get_parent().price /=1.25
