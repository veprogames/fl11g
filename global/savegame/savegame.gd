extends Node

const SAVEGAME_PATH = "user://fl11g.tres"

var save := SaveGameData.new()

func save_game() -> void:
	ResourceSaver.save(save, SAVEGAME_PATH)

func load_game() -> void:
	if ResourceLoader.exists(SAVEGAME_PATH):
		save = load(SAVEGAME_PATH)
