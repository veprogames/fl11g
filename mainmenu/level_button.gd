extends Control

@export var level_data: LevelData
@export var debug_only := false

@onready var label_title: Label = $Content/Info/LabelTitle
@onready var label_percent: Label = $Content/Info/LabelPercent
@onready var button_play: Button = $Content/HBoxContainer/ButtonPlay

var Scene: PackedScene

func _ready() -> void:
	if debug_only and not OS.is_debug_build():
		queue_free()
	
	Scene = load(level_data.scene_path)
	label_title.text = level_data.title
	
	var percentage := level_data.get_current_percentage()
	label_percent.text = "%.2f%%" % (percentage * 100)
	label_percent.add_theme_color_override("font_color", Color.WHITE.lerp(Color.ORANGE, percentage ** 2.0))

	if not level_data.is_unlocked():
		button_play.disabled = true
		label_percent.text = "Need %.2f%%" % (level_data.requirement * 100)
		label_percent.add_theme_color_override("font_color", Color.RED)


func _on_button_play_pressed() -> void:
	SceneManager.change_scene(Scene)

func _on_button_music_pressed() -> void:
	OS.shell_open(level_data.song_url)
