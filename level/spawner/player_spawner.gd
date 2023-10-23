class_name PlayerSpawner
extends Node2D

signal player_spawned()

@export var level: Level

@onready var spawn_timer := $SpawnTimer as Timer

var Player := preload("res://player/player.tscn")

func spawn_player() -> void:
	var player := Player.instantiate() as Player
	if player:
		player.position = position
		level.add_player(player)

func start_respawning_player() -> void:
	spawn_timer.start()
	await spawn_timer.timeout
	spawn_player()
	player_spawned.emit()
