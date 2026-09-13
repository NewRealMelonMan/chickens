extends CanvasLayer
@export var Mone: int = 99

func _ready() -> void:
	$Label.text = "-" + str(Mone) + "$"

func _process(delta: float) -> void:
	offset.y -= delta *100
	$Label.modulate.a -=0.01
	if $Label.modulate.a <=0:
		queue_free()
