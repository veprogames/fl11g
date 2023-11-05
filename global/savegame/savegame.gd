extends Node

const SAVEGAME_PATH = "user://fl11g.tres"

var save := SaveGameData.new()

func _init() -> void:
	load_game()

func get_total_percentage() -> float:
	return save.get_total_percentage()

func save_game() -> void:
	ResourceSaver.save(save, SAVEGAME_PATH)

func load_game() -> void:
	if ResourceLoader.exists(SAVEGAME_PATH):
		save = load(SAVEGAME_PATH)
