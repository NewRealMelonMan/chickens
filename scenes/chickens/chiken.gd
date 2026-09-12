extends Node2D

@onready var position_start = position
var mouse_entered: bool
var egg_create_timer: float
var egg_scene = preload("res://scenes/eggs/egg.tscn")
var feather_scene = preload("res://scenes/feather.tscn")
var star_scene = preload("res://scenes/star.tscn")
var point_to_walk_to: Vector2
var speed_to_walk: float
var timer_to_walk: float
var wanna_walk = false
var do_shine = false
var do_eggs = true
var timer_to_shine: float

func get_width_diff_from_base() -> float:
	const BASE_WIDTH := 1280.0
	var current_width = get_viewport_rect().size.x
	var diff = current_width - BASE_WIDTH
	return diff

func _ready() -> void:
	add_to_group("chickens")
	$Area2D.add_to_group("chickens_area")
	get_width_diff_from_base()
	prepare_to_move()
	timer_to_walk = randi_range(1,5)
	$AnimatedSprite2D.play("boom")
	boing()
	egg_create_random_timer()

func prepare_to_move():
	wanna_walk = false
	point_to_walk_to = Vector2(randi_range(100, 1120 + get_width_diff_from_base()), randi_range(50, 670))
	speed_to_walk = abs(point_to_walk_to.x - position.x)/100 + abs(point_to_walk_to.y - position.y)/100
	var to_walk_tween = create_tween()
	to_walk_tween.tween_property(self, "position", point_to_walk_to, speed_to_walk)
	to_walk_tween.tween_callback(change_walk_wanna)
	if $AnimationPlayer.current_animation != "boing":
		$AnimationPlayer.play("walk")

func change_walk_wanna():
	wanna_walk = true

func _on_area_2d_mouse_entered() -> void:
	mouse_entered = true

func _on_area_2d_mouse_exited() -> void:
	mouse_entered = false

func _process(delta: float) -> void:
	if wanna_walk:
		if $AnimationPlayer.current_animation != "boing":
			$AnimationPlayer.play("idle")
		timer_to_walk -= delta
	
	timer_to_shine-=delta

	if timer_to_shine <= 0 and do_shine:
		var star = star_scene.instantiate()
		get_tree().current_scene.add_child(star)
		star.z_index = 2
		star.global_position = self.global_position
		timer_to_shine = randi_range(1, 3)

	if timer_to_walk <= 0:
		prepare_to_move()
		timer_to_walk = randi_range(3,10)

	if do_eggs:
		egg_create_timer -= delta
		if egg_create_timer <= 0:
			boing()
			var egg = egg_scene.instantiate()
			get_tree().current_scene.add_child(egg)
			egg.position.x = position.x
			egg.position.y = position.y+35
			egg_create_random_timer()

func boing():
	$AnimationPlayer.seek(0, true)
	$AnimationPlayer.play("boing")

func egg_create_random_timer():
	egg_create_timer = randi_range(5,15)

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if $AnimationPlayer.current_animation == "boing" and wanna_walk:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("walk")

func kill_chicken():
	for i in range(5):
		var feather = feather_scene.instantiate()
		get_tree().current_scene.add_child(feather)
		feather.position.x = position.x
		feather.position.y = position.y
	queue_free()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left mouse") or (event is InputEventScreenTouch and event.pressed):
		boing()
		if Global.hammer:
			kill_chicken()
