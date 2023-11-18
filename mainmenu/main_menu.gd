extends Node2D

@onready var label_version: Label = $CanvasLayer/VBoxContainer/LabelVersion

func _ready() -> void:
	label_version.text = ProjectSettings.get("application/version/version_pretty")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("game_quit"):
		SceneManager.quit_game()

func _on_button_quit_pressed() -> void:
	SceneManager.quit_game()


func _on_label_subtitle_meta_clicked(meta) -> void:
	OS.shell_open(meta)
