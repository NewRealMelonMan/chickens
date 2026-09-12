extends Node2D

@onready var mouse_scale_start = $mouse/mouse.scale

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left mouse"):
		$mouse/hammer.rotation_degrees = -50
		$mouse/mouse.scale = Vector2(mouse_scale_start.x/1.25, mouse_scale_start.x/1.25)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if OS.get_name() in ["Android", "iOS"]:
		queue_free()
	else:
		pass
	

func _process(delta: float) -> void:
	$mouse.offset = get_global_mouse_position()
	
	if $mouse/hammer.rotation_degrees <=0:
		$mouse/hammer.rotation_degrees +=1
	if $mouse/mouse.scale.x < mouse_scale_start.x:
		$mouse/mouse.scale += Vector2(0.0025, 0.0025)
	$mouse.offset = get_global_mouse_position()
	if Global.hammer:
		$mouse/hammer.visible = true
		$mouse/mouse.visible = false
	else:
		$mouse/hammer.visible = false
		$mouse/mouse.visible = true
