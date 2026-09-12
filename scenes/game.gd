extends Node2D

const DEFAULT_CHICKEN := "res://scenes/chickens/chiken.tscn"

var time_for_save:float = 60.0
var is_pressed: bool = false
var offset_shop_on_start
var effect_money = preload("res://scenes/money_effect.tscn")
var chicks_for_shop = preload("res://scenes/chickens/chicken_random.gd")
var money_minus_99 = preload("res://scenes/money_effect_minus.tscn")
var price:int
var reroll_price = 99
@onready var hammer_scale_start = $HUD/shop/hammer/Sprite2D.scale

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
	$HUD/shop/chicks/Node2D.redy.connect(_update_price_for_reroll)
	Savedata.load_game()
	_spawn_chickens()
	get_width_diff_from_base()
	offset_shop_on_start = $HUD/shop.offset.x + get_width_diff_from_base()
	$"egg basket".position.y += get_height_diff_from_base() 
	$"egg basket".position.x += get_width_diff_from_base()
	$HUD/shop.offset.x = offset_shop_on_start
	$"egg basket".add_to_group("egg_basket")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$HUD/shop/reroll/Label.text = "$" + str(Global.reload_price)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left mouse") or (event is InputEventScreenTouch and event.pressed):
		if is_pressed:
			create_tween().tween_property($HUD/shop/squar/arrow, "rotation_degrees", 0, 2.0)\
			.set_trans(Tween.TRANS_EXPO)\
			.set_ease(Tween.EASE_OUT)

			create_tween().tween_property($HUD/shop, "offset:x", offset_shop_on_start, 2.0)\
			.set_trans(Tween.TRANS_EXPO)\
			.set_ease(Tween.EASE_OUT)

			is_pressed =false

		elif !is_pressed:
			create_tween().tween_property($HUD/shop/squar/arrow, "rotation_degrees", 180, 2.0)\
			.set_trans(Tween.TRANS_EXPO)\
			.set_ease(Tween.EASE_OUT)

			create_tween().tween_property($HUD/shop, "offset:x", offset_shop_on_start-500, 1.5)\
			.set_trans(Tween.TRANS_BOUNCE)\
			.set_ease(Tween.EASE_OUT)

			is_pressed =true

func _process(delta: float) -> void:
	time_for_save -= delta
	if time_for_save <=0:
		Savedata.save_game()
		time_for_save = 60
	if $HUD/shop/hammer/Sprite2D.scale.x < hammer_scale_start.x:
		$HUD/shop/hammer/Sprite2D.scale += Vector2(0.0025, 0.0025)
	$HUD/mone/Label.text = str(Global.money)
	if Global.hammer:
		$HUD/shop/hammer/Sprite2D2.visible = true
	else:
		$HUD/shop/hammer/Sprite2D2.visible = false


func _on_area_2d_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left mouse") or (event is InputEventScreenTouch and event.pressed):
		if Global.hammer:
			Global.hammer = false
		else:
			Global.hammer = true
		$HUD/shop/hammer/Sprite2D.scale = Vector2(hammer_scale_start.x/1.25, hammer_scale_start.x/1.25)


func _on_button_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left mouse") or (event is InputEventScreenTouch and event.pressed):
		Savedata.save_game()
		Transition.change_scene("res://scenes/main_menu.tscn")


func _on_area_reroll_chicks_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left mouse") and Global.money >= Global.reload_price or\
	(event is InputEventScreenTouch and event.pressed) and Global.money >= Global.reload_price:
		get_tree().call_group("random_chickens_reroll", "reroll_chicken")
		var money = money_minus_99.instantiate()
		get_tree().current_scene.add_child(money)
		money.offset = event.position
		Global.money -= Global.reload_price
		Global.reload_price +=99
		$HUD/shop/reroll/Label.text = "$" + str(Global.reload_price)

func _update_price_for_reroll():
	if Global.reload_price > 99:
		Global.reload_price -=99
		$HUD/shop/reroll/Label.text = "$" + str(Global.reload_price)

#saving code moved to "res://scenes/savedata.gd"
var chicken_scenes = Savedata.chicken_scenes


func _spawn_chickens() -> void:
	
	if chicken_scenes.is_empty():
		chicken_scenes.append(DEFAULT_CHICKEN)
	
	for path in chicken_scenes:
		var chicken = load(path).instantiate()
		add_child(chicken)
		chicken.position.x = randi_range(50, 1230)
		chicken.position.y = randi_range(50, 680)

	for shop in get_tree().get_nodes_in_group("random_chickens_reroll"):
		if not shop.bought_chick.is_connected(_on_chicken_bought):
			shop.bought_chick.connect(_on_chicken_bought)

func _on_chicken_bought() -> void:
	Savedata.save_game()

func _on_add_mone_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left mouse") or (event is InputEventScreenTouch and event.pressed):
		Global.money +=999
