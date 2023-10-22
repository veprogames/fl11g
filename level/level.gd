class_name Level
extends Node2D

@export var level_data: LevelData

@onready var music_player := $Audio/Music as AudioStreamPlayer
@onready var camera := $LevelCamera as Camera2D
@onready var finish := $Gameplay/FinishLine as FinishLine
@onready var player_camera_manager := $Logic/PlayerCameraManager as PlayerCameraManager

func _ready() -> void:
	if level_data:
		music_player.stream = level_data.music
		music_player.play()

func get_camera_position() -> Vector2:
	return camera.global_position

func get_length() -> float:
	return finish.position.x

func get_percentage() -> float:
	var x := player_camera_manager.get_highest_player_x()
	return x / get_length()
