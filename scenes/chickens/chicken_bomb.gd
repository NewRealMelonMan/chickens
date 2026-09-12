extends "res://scenes/chickens/chiken.gd"

var explosion = preload("res://scenes/chickens/explosion.tscn")
var can_kill_chick: bool

func _ready() -> void:
	super()
	egg_scene = preload("res://scenes/eggs/egg_bomb.tscn")
	add_to_group("cant_expode")

func kill_chicken():
	var explosion_instance = explosion.instantiate()
	get_tree().current_scene.add_child(explosion_instance)
	explosion_instance.position.x = position.x
	explosion_instance.position.y = position.y
	can_kill_chick = true

	for a in $Area2D2.get_overlapping_areas():
		var target = a.get_parent()
		if target == self:
			continue
		if a.is_in_group("chickens_area") and not target.is_in_group("cant_explode"):
			target.kill_chicken()

	queue_free()

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if can_kill_chick == true:
		if area.is_in_group("chickens_area") and not area.get_parent().is_in_group("cant_explode"):
			area.get_parent().kill_chicken()
