extends Node

#THIS CODE IS REALLY SENSITIVE AND MIGHT NEED TO BE OPTIMIZED

const SAVE_PATH := "user://save.json"
var chicken_scenes: Array = []
var shop_stuff: Array = []

var data: Dictionary = {
	"money": 0,
	"chickens": chicken_scenes,
	"chicken_level": 0,
	"reload_price": 99,
	"current_shop": shop_stuff
}

func save_game() -> void:
	chicken_scenes.clear()

	for chicken in get_tree().get_nodes_in_group("chickens"):
		chicken_scenes.append(chicken.scene_file_path)

	data["money"] = Global.money
	data["chicken_level"] = Global.chicken_level
	data["chickens"] = chicken_scenes

	shop_stuff.clear()

	for shop in get_tree().get_nodes_in_group("random_chickens_reroll"):
		shop_stuff.append(shop.chick_stuff.duplicate(true))
	data["current_shop"] = shop_stuff
	
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	
	
func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file")
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text := file.get_as_text()
	file.close()
	var loadedData = JSON.parse_string(text)

	if not loadedData is Dictionary:
		print("Save file is invalid.")

	# Adds missing stuff from the save file, in case of save file content expansion
	for key in data:
		if not loadedData.has(key):
			loadedData[key] = data[key]

	data = loadedData

	Global.money = int(data.get("money", 0))
	Global.reload_price = int(data.get("reload_price", 99))
	Global.chicken_level = int(data.get("chicken_level", 0))

	var loaded_chickens = data.get("chickens", [])
	chicken_scenes = loaded_chickens.duplicate()
		
	var loaded_shop = data.get("current_shop", [])
	shop_stuff = loaded_shop.duplicate(true)
	for shop in shop_stuff:
		if not shop.has("bought"):
			shop["bought"] = false
