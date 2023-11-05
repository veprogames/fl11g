class_name SaveGameData
extends Resource

# keys will be added automatically
@export var levels: Dictionary = {

}

func get_total_percentage() -> float:
	var total := 0.0
	for entry in levels.values():
		var level := entry as LevelStats
		if level and not level.debug:
			total += level.percentage
	return total
