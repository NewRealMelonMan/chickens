extends Node

var money:int = 0
var hammer:bool
var chicken_level: int = -1
var reset = false
var music = 100
var sfx = 100
var reload_price:int = 99

func get_price_multiplier() -> float:
	if get_tree().current_scene.name != "Game":
		return 1.0
	var count = get_tree().get_nodes_in_group("chickens").size()-1
	return pow(1.05, count)
