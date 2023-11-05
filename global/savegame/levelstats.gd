class_name LevelStats
extends Resource

@export var attempts := 0
@export var beaten_at_attempt := 0
@export var percentage := 0.0
@export var debug := false

func is_completed() -> bool:
	return percentage >= 1.0
