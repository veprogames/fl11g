class_name LevelProgressBar
extends Control

@export var value := 0.0 : set = _set_value, get = _get_value

@onready var bar: ProgressBar = $Bar
@onready var label_percent: Label = $LabelPercent

func _get_value() -> float:
	return value

func _set_value(new_value: float) -> void:
	value = new_value
	bar.value = new_value
	label_percent.text = "%.2f%%" % (new_value * 100.0)
	label_percent.add_theme_color_override("font_color", Color.WHITE.lerp(Color.ORANGE, new_value ** 2.0))
