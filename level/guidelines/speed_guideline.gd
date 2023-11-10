class_name SpeedGuideline
extends Resource

@export var x: float = 0.0
@export var speed_level: int = 0

func _init(x_: float = 0, speed_level_: int = 0) -> void:
	self.x = x_
	self.speed_level = speed_level_
