extends Control

const BASE_WIDTH := 1280.0
const BASE_HEIGHT := 720.0

func _ready() -> void:
	# сбрасываем anchors в Top Left, чтобы position/scale не конфликтовали с anchor-системой
	set_anchors_preset(Control.PRESET_TOP_LEFT)
	
	# pivot в (0,0), чтобы scale считался от левого верхнего угла, а не от центра
	pivot_offset = Vector2.ZERO
	
	get_viewport().size_changed.connect(_update_scale)
	_update_scale()

func _update_scale() -> void:
	var screen_size = get_viewport_rect().size
	
	var scale_x = screen_size.x / BASE_WIDTH
	var scale_y = screen_size.y / BASE_HEIGHT
	var final_scale = min(scale_x, scale_y)
	
	scale = Vector2(final_scale, final_scale)
	
	var scaled_size = Vector2(BASE_WIDTH, BASE_HEIGHT) * final_scale
	position = (screen_size - scaled_size) / 2
