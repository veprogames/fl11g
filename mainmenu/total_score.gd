extends Control

@export var text_gradient: Gradient

@onready var label_percentage: Label = $HBoxContainer/LabelPercentage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total := Savegame.get_total_percentage()
	var font_size := label_percentage.get_theme_font_size("font_size")
	var gradient_position := clampf(total / 10.0, 0.0, 1.0)
	
	label_percentage.text = "%.2f%%" % (total * 100)
	label_percentage.add_theme_font_size_override("font_size", int(font_size * remap(total, 0.0, 4.0, 0.6, 1.4)))
	label_percentage.add_theme_color_override("font_color", text_gradient.sample(gradient_position))
