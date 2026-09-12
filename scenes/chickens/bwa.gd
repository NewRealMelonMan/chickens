extends Node2D

@onready var position_start = position
var mouse_entered: bool
var point_to_walk_to: Vector2
var speed_to_walk: float
var timer_to_walk: float
var wanna_walk = false

func _ready() -> void:
	prepare_to_move()
	timer_to_walk = randi_range(1,5)
	$AnimatedSprite2D.play("boom")
	boing()

func prepare_to_move():
	wanna_walk = false
	point_to_walk_to = Vector2(randi_range(100, 1120), randi_range(50, 670))
	speed_to_walk = abs(point_to_walk_to.x - position.x)/100 + abs(point_to_walk_to.y - position.y)/100
	if point_to_walk_to.x> position.x:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left mouse") and mouse_entered or (event is InputEventScreenTouch and event.pressed):
		boing()

func _process(delta: float) -> void:
	if wanna_walk:
		if $AnimationPlayer.current_animation != "boing":
			$AnimationPlayer.play("idle")
		timer_to_walk -= delta

	if timer_to_walk <= 0:
		prepare_to_move()
		timer_to_walk = randi_range(3,10)

func boing():
	$AnimationPlayer.seek(0, true)
	$AnimationPlayer.play("boing")

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if $AnimationPlayer.current_animation == "boing" and wanna_walk:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("walk")
