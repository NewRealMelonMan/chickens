extends Node2D

signal redy
signal bought_chick


var chicks = {
		"chicken_poop": {
		"texture": preload("res://sprites/chicken_poop.png"),
		"scene": preload("res://scenes/chickens/chicken_poop.tscn"),
		"price": 0,
		"chance": 1,
		"level": -2
	},
	"chicken": {
		"texture": preload("res://sprites/chicken.png"),
		"scene": preload("res://scenes/chickens/chiken.tscn"),
		"price": 20,
		"chance": 100,
		"level": 0
	},
	"chicken_green": {
		"texture": preload("res://sprites/chicken_green.png"),
		"scene": preload("res://scenes/chickens/chicken_green.tscn"),
		"price": 40,
		"chance": 80,
		"level": 1
	},
	"chicken_red": {
		"texture": preload("res://sprites/chicken_red.png"),
		"scene": preload("res://scenes/chickens/chicken_red.tscn"),
		"price": 40,
		"chance": 80,
		"level": 1
	},
	"chicken_bronze": {
		"texture": preload("res://sprites/chicken_bronze.png"),
		"scene": preload("res://scenes/chickens/chicken_bronze.tscn"),
		"price": 80,
		"chance": 50,
		"level": 2
	},
	"chicken_bread": {
		"texture": preload("res://sprites/chicken_bread.png"),
		"scene": preload("res://scenes/chickens/chicken_bread.tscn"),
		"price": 160,
		"chance": 35,
		"level": 3
	},
	"chicken_egg": {
		"texture": preload("res://sprites/chicken_egg.png"),
		"scene": preload("res://scenes/chickens/chicken_egg.tscn"),
		"price": 90,
		"chance": 40,
		"level": 4
	},
	"duck": {
		"texture": preload("res://sprites/duck.png"),
		"scene": preload("res://scenes/chickens/duck.tscn"),
		"price": 20,
		"chance": 100,
		"level": 4
	},
	"chicken_multi": {
		"texture": preload("res://sprites/chicken_mutant.png"),
		"scene": preload("res://scenes/chickens/chicken_multi.tscn"),
		"price": 320,
		"chance": 25,
		"level": 4
	},
	"chicken_silver": {
		"texture": preload("res://sprites/chicken_silver.png"),
		"scene": preload("res://scenes/chickens/chicken_silver.tscn"),
		"price": 640,
		"chance": 18,
		"level": 5
	},
	"chicken_random": {
		"texture": preload("res://sprites/chicken_random.png"),
		"scene": preload("res://scenes/chickens/chicken_random.tscn"),
		"price": randi_range(0, 9999),
		"chance": 1,
		"level": 5
	},
	"chicken_star": {
		"texture": preload("res://sprites/chicken_star.png"),
		"scene": preload("res://scenes/chickens/chicken_star.tscn"),
		"price": 1280,
		"chance": 12,
		"level": 6
	},
	"chicken_pixel": {
		"texture": preload("res://sprites/chicken_pixel.png"),
		"scene": preload("res://scenes/chickens/chicken_pixel.tscn"),
		"price": 2560,
		"chance": 10,
		"level": 7
	},
	"chicken_zombie": {
		"texture": preload("res://sprites/chicken_zombie.png"),
		"scene": preload("res://scenes/chickens/chicken_zombie.tscn"),
		"price": 5120,
		"chance": 10,
		"level": 8
	},
	"chicken_golden": {
		"texture": preload("res://sprites/chicken_gold.png"),
		"scene": preload("res://scenes/chickens/chicken_golden.tscn"),
		"price": 10240,
		"chance": 10,
		"level": 9
	},
	"chicken_alien": {
		"texture": preload("res://sprites/chicken_alien.png"),
		"scene": preload("res://scenes/chickens/chicken_alien.tscn"),
		"price": 20480,
		"chance": 10,
		"level": 10
	},
		"chicken_multiply_money": {
		"texture": preload("res://sprites/chicken_money_dup.png"),
		"scene": preload("res://scenes/chickens/chicken_multiply_money.tscn"),
		"price": 500,
		"chance": 10,
		"level": 11
	},
	"chicken_diamond": {
		"texture": preload("res://sprites/chicken_diamond.png"),
		"scene": preload("res://scenes/chickens/chicken_diamond.tscn"),
		"price": 40960,
		"chance": 10,
		"level": 11
	},
	"chicken_bomb": {
		"texture": preload("res://sprites/chicken_bomb.png"),
		"scene": preload("res://scenes/chickens/chicken_bomb.tscn"),
		"price": 81920,
		"chance": 10,
		"level": 12
	},
	"chicken_rupi": {
		"texture": preload("res://sprites/chicken_rubi.png"),
		"scene": preload("res://scenes/chickens/chicken_rupi.tscn"),
		"price": 163840,
		"chance": 10,
		"level": 13
	}
}
@export var chick_stuff: Dictionary = {
	"chicken": "",
	"storedprice": 0,
	"shopID": 0,
	"bought": false
}
var timer_for_chick: float

func reroll_chicken() -> void:
	timer_for_chick = 5
	$no.visible = false
	$price.visible = true

	var total_chance := 0

	for key in chicks.keys():
		if chicks[key]["level"] <= Global.chicken_level + 1:
			total_chance += chicks[key]["chance"]

	var roll = randi() % total_chance
	var current := 0

	for key in chicks.keys():
		if chicks[key]["level"] <= Global.chicken_level + 1:
			current += chicks[key]["chance"]

			if roll < current:
				chick_stuff.set("chicken", key)
				break

	update_price_display()
	$chick.texture = chicks[chick_stuff.get("chicken")]["texture"]

func update_price_display() -> void:
	var final_price = int(chicks[chick_stuff.get("chicken")]["price"] * Global.get_price_multiplier())
	if final_price > 0:
		$price.text = "$" + str(final_price)
	else:
		$price.text = "FREE"
	chick_stuff.set("storedprice", final_price)

func load_shop_data() -> void:
	for shop_data in Savedata.shop_stuff:
		if int(shop_data["shopID"]) == int(chick_stuff["shopID"]):
			chick_stuff = shop_data.duplicate()
			$chick.texture = chicks[chick_stuff["chicken"]]["texture"]
			
			if chick_stuff["bought"] == true:
				$no.visible = true
				$price.visible = false
			else:
				$no.visible = false
				$price.visible = true
			
			var price = chick_stuff["storedprice"]

			if price > 0:
				$price.text = "$" + str(price)
			else:
				$price.text = "FREE"
			
			timer_for_chick = 5

func initialize_shop() -> void:
	if Savedata.shop_stuff.is_empty():
		reroll_chicken()
	else:
		load_shop_data()

	update_price_display()


func _ready() -> void:
	add_to_group("random_chickens_reroll")
	if Savedata.shop_stuff.is_empty():
		reroll_chicken()
	else:
		load_shop_data()
	call_deferred("update_price_display")

func _process(delta: float) -> void:
	timer_for_chick -= delta
	if timer_for_chick <= 0:
		redy.emit()
		reroll_chicken()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var is_click = event.is_action_pressed("left mouse") or (event is InputEventScreenTouch and event.pressed)
	if not is_click:
		return

	if $no.visible:
		return

	var final_price = int(chicks[chick_stuff.get("chicken")]["price"] * Global.get_price_multiplier())
	if final_price > Global.money:
		return

	$no.visible = true

	$price.visible = false
	Global.money -= final_price
	bought_chick.emit()
	Savedata.save_game()
	if chicks[chick_stuff.get("chicken")]["level"] > Global.chicken_level:
		Global.chicken_level = chicks[chick_stuff.get("chicken")]["level"]
	print(Global.chicken_level)

	var new_chicken = chicks[chick_stuff.get("chicken")]["scene"].instantiate()
	get_tree().current_scene.add_child(new_chicken)
	new_chicken.position.x = randi_range(50, 1230)
	new_chicken.position.y = randi_range(50, 680)

	for node in get_tree().get_nodes_in_group("random_chickens_reroll"):
		node.update_price_display()
