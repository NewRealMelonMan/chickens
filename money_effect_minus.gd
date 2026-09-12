extends CanvasLayer

func _process(delta: float) -> void:
	offset.y -= delta *100
	$Label.modulate.a -=0.01
	if $Label.modulate.a <=0:
		queue_free()
