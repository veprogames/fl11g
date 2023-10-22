class_name Level
extends Node2D

@export var level_data: LevelData

@onready var music_player := $Audio/Music as AudioStreamPlayer

func _ready() -> void:
	if level_data:
		music_player.stream = level_data.music
		music_player.play()
