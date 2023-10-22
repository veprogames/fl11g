class_name Level
extends Node2D

@export var level_data: LevelData

@onready var music_player := $Audio/Music as AudioStreamPlayer
@onready var camera := $Players/Player/Camera2D as Camera2D

func _ready() -> void:
	if level_data:
		music_player.stream = level_data.music
		music_player.play()

func get_camera_position() -> Vector2:
	return camera.global_position
