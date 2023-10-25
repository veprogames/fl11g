class_name LevelData
extends Resource

@export var id: String
@export var music: AudioStreamMP3
@export var title: String

func create_levelstats_in_save() -> void:
	Savegame.save.levels[id] = LevelStats.new()

func get_stats() -> LevelStats:
	return Savegame.save.levels[id] as LevelStats

func get_current_attempt() -> int:
	if not id in Savegame.save.levels:
		return 0
	var stats := get_stats()
	return stats.attempts if stats != null else 0

func add_attempt_to_save() -> void:
	if not id in Savegame.save.levels:
		create_levelstats_in_save()
	var stats := get_stats()
	if stats:
		stats.attempts += 1

func submit_percentage_to_savegame(percentage: float) -> void:
	if not id in Savegame.save.levels:
		create_levelstats_in_save()
	var stats := get_stats()
	if stats:
		stats.percentage = maxf(stats.percentage, percentage)

func is_completed() -> bool:
	var stats := get_stats()
	return stats != null and stats.is_completed()
