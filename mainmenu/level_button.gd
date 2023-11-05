extends Control

@export var level_data: LevelData
@export var debug_only := false

@onready var label_title: Label = $Content/Info/LabelTitle
@onready var label_percent: Label = $Content/Info/LabelPercent

var Scene: PackedScene

func _ready() -> void:
	if debug_only and not OS.is_debug_build():
		queue_free()
	
	Scene = load(level_data.scene_path)
	label_title.text = level_data.title
	
	var percentage := level_data.get_current_percentage()
	label_percent.text = "%.2f%%" % (percentage * 100)
	if percentage >= 1.0:
		label_percent.add_theme_color_override("font_color", Color.ORANGE)


func _on_button_play_pressed() -> void:
	SceneManager.change_scene(Scene)

func _on_button_music_pressed() -> void:
	OS.shell_open(level_data.song_url)
