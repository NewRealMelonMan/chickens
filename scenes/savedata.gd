extends Node

const SAVE_PATH := "user://save.json"
var chicken_scenes: Array = []
var shop_stuff: Array = []

var data = {
	"money": Global.money,
	"chickens": chicken_scenes,
	"chicken_level": Global.chicken_level,
	"reload_price": Global.reload_price,
	"current_shop": shop_stuff
}

func save_game() -> void:
	data.set("money", Global.money)
	
	#maybe remove the chicken scenes clear if it causes problems idfk
	chicken_scenes.clear()
	for chicken in get_tree().get_nodes_in_group("chickens"):
		chicken_scenes.append(chicken.scene_file_path)
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game() -> void :
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file: = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text: = file.get_as_text()
	var loadedData = JSON.parse_string(text)
	
	Global.money = int(data.get("money", 0))
	Global.reload_price = int(data.get("reload_price", 99))
	Global.chicken_level = int(data.get("chicken_level", 0))
	
	var loaded_chickens = data.get("chickens", [])
	if loaded_chickens is Array:
		chicken_scenes = loaded_chickens
	else:
		chicken_scenes = []

	if loadedData is Dictionary:
		for key in data:
			if not loadedData.has(key):
				loadedData[key] = data[key]

		data = loadedData
