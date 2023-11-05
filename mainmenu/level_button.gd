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
	label_percent.text = "%02d%%" % (level_data.get_current_percentage() * 100)


func _on_button_play_pressed() -> void:
	SceneManager.change_scene(Scene)
