extends Node2D

var strength: float = 0.1 
var offset_cat_jump: float = 0.0
var drag_music:bool
var drag_sfx:bool

func _on_credits_pressed() -> void:
	Transition.change_scene("res://scenes/credits.tscn")

func get_width_diff_from_base() -> float:
	const BASE_WIDTH := 1280.0
	var current_width = get_viewport_rect().size.x
	var diff = current_width - BASE_WIDTH
	return diff

func get_height_diff_from_base() -> float:
	const BASE_HEIGHT := 720.0
	var current_width = get_viewport_rect().size.y
	var diff = current_width - BASE_HEIGHT
	return diff

func _ready() -> void:
	$options/sfx2.value = Global.sfx
	$options/music2.value = Global.music
	$"options/music percent".text = str(int($options/music2.value))
	$"options/sfx percent".text = str(int($options/sfx2.value))
	$Sprite2D.position.x +=get_width_diff_from_base()
	$VBoxContainer.position.x +=get_width_diff_from_base()/2
	$VBoxContainer.position.y +=get_height_diff_from_base()/2
	$"ParallaxBackground/front chicks/Sprite2D3".position.y+= get_height_diff_from_base()
	$"ParallaxBackground/back chicks/Sprite2D2".position.y+= get_height_diff_from_base()
	$options.position.x += get_width_diff_from_base()
	$options.position.y+= get_height_diff_from_base()
	$Sprite2D/AnimationPlayer.play("static")

func _on_new_game_pressed() -> void:
	Transition.change_scene("res://scenes/game.tscn")

func _process(delta: float) -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	var mouse_pos = get_viewport().get_mouse_position()
	
	var offset = (mouse_pos - viewport_size / 2) / viewport_size
	
	$ParallaxBackground.scroll_offset = -offset * strength * 1000 + Vector2(0, offset_cat_jump)

	if drag_music:
		$"options/music percent".text = str(int($options/music2.value))
	if drag_sfx:
		$"options/sfx percent".text = str(int($options/sfx2.value))

func _on_options_pressed() -> void:
	if !$options.visible:
		$options.visible = true

func _on_music_2_drag_started() -> void:
	if $options.visible:
		drag_music = true
func _on_music_2_drag_ended(value_changed: bool) -> void:
	if $options.visible:
		drag_music = false

func _on_sfx_2_drag_ended(value_changed: bool) -> void:
	if $options.visible:
		drag_sfx = true
func _on_sfx_2_drag_started() -> void:
	if $options.visible:
		drag_sfx = false
