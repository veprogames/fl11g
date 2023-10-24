class_name LevelGuidelineData
extends Resource

@export var lines: Array[float] = []

func add_line(x: float) -> void:
	lines.append(x)
