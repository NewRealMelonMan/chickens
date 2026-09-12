extends Node2D

func _ready() -> void:
	$Node2D/AnimationPlayer.play("idle")

func _on_button_pressed() -> void:
	Transition.change_scene("res://scenes/main_menu.tscn")
