class_name Level
extends Node2D

@export var level_data: LevelData

@onready var music_player := $Audio/Music as AudioStreamPlayer
@onready var camera := $Players/Player/Camera2D as Camera2D
@onready var finish := $Gameplay/FinishLine as FinishLine
@onready var player := $Players/Player as Player

func _ready() -> void:
	if level_data:
		music_player.stream = level_data.music
		music_player.play()

func get_camera_position() -> Vector2:
	return camera.global_position

func get_length() -> float:
	return finish.position.x

func get_percentage() -> float:
	return player.position.x / get_length()
