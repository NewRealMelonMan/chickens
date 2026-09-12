extends Node2D

var price = 1
var timer: float = 10
var goin_to_basket: bool
var timer_to_shine: float
var star_scene = preload("res://scenes/star.tscn")
var do_shine = false
@onready var egg_texture = $Sprite2D

func _ready() -> void:
	add_to_group("eggs")
	$Area2D.add_to_group("eggs_area")
	$Label.visible = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventScreenTouch and event.pressed) or event is InputEventScreenDrag:
		if !goin_to_basket and get_tree().get_first_node_in_group("egg_basket"):
			go_to_basket()

func go_to_basket():
		egg_texture.modulate.a = 99
		z_index = 99
		Global.money += int(price)
		var tween = create_tween()
		tween.tween_property(self, "global_position", get_tree().get_first_node_in_group("egg_basket").position , 0.50)
		tween.tween_callback(effect)
		$Label.text = "$" + str(int(price))
		goin_to_basket = true

func effect():
	$Label.visible = true
	egg_texture.visible = false

func _process(delta: float) -> void:
	timer -= delta
	if timer <=0:
		egg_texture.modulate.a -= 0.75 * delta
	if $Label.visible:
		position.y-=1
		modulate.a -=0.01
	if egg_texture.modulate.a <=0 or modulate.a <=0:
		queue_free()

	timer_to_shine-=delta

	if timer_to_shine<=0 and do_shine:
		var star = star_scene.instantiate()
		get_tree().current_scene.add_child(star)
		star.global_position = self.global_position
		star.z_index = 2
		timer_to_shine=randi_range(1,3)

func _on_area_2d_mouse_entered() -> void:
	if !goin_to_basket and get_tree().get_first_node_in_group("egg_basket"):
		go_to_basket()
