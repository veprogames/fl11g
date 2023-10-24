class_name LevelData
extends Resource

@export var id: String
@export var music: AudioStreamMP3
@export var title: String

func get_current_attempt() -> int:
	if not id in Savegame.save.levels:
		return 0
	var stats := Savegame.save.levels[id] as LevelStats
	return stats.attempts

func add_attempt_to_save() -> void:
	if not id in Savegame.save.levels:
		return
	var stats := Savegame.save.levels[id] as LevelStats
	if stats:
		stats.attempts += 1

func submit_savegame_progress(progress: float) -> void:
	if not id in Savegame.save.levels:
		return
	var stats := Savegame.save.levels[id] as LevelStats
	if stats:
		stats.percentage = maxf(stats.percentage, progress)
