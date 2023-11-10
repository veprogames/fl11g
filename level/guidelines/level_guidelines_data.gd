class_name LevelGuidelineData
extends Resource

@export var lines: Array[float] = []
@export var speed_lines: Array[SpeedGuideline] = []

func add_line(x: float) -> void:
	lines.append(x)

func add_speed_line(x: float, speed_level: int) -> void:
	speed_lines.append(SpeedGuideline.new(x, speed_level))
