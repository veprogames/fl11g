extends Node2D

@onready var scene := preload("res://level/levels/01-soar/level_soar.tscn")

func _on_button_pressed() -> void:
	SceneManager.change_scene(scene)
