extends VBoxContainer

@export var hover_scale: float = 1.25
@export var speed: float = 8.0

var buttons: Array[Button] = []
var target_scales: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is Button:
			buttons.append(child)
			child.pivot_offset = child.size / 2
			target_scales[child] = Vector2.ONE
			
			child.mouse_entered.connect(_on_button_mouse_entered.bind(child))
			child.mouse_exited.connect(_on_button_mouse_exited.bind(child))

func _process(delta: float) -> void:
	for button in buttons:
		button.scale += (target_scales[button] - button.scale) * speed * delta

func _on_button_mouse_entered(button: Button) -> void:
	target_scales[button] = Vector2.ONE * hover_scale

func _on_button_mouse_exited(button: Button) -> void:
	target_scales[button] = Vector2.ONE
