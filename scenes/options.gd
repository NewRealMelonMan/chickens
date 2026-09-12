extends ColorRect

@onready var text_on_back = $"reset data".text

func _ready() -> void:
	visible = false

func _on_back_pressed() -> void:
	if visible:
		visible = false
		$"reset data".text = text_on_back

func _on_reset_data_pressed() -> void:
	if visible and $"reset data".text == text_on_back:
		$"reset data".text = "confirm?"
	elif $"reset data".text == "confirm?" and visible:
		if FileAccess.file_exists("user://save.json"):
			DirAccess.remove_absolute(ProjectSettings.globalize_path("user://save.json"))
		visible = false
