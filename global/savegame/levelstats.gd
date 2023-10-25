class_name LevelStats
extends Resource

@export var attempts := 0
@export var percentage := 0.0

func is_completed() -> bool:
	return percentage >= 1.0
