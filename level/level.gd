class_name Level
extends Node2D

@export var level_data: LevelData

@onready var PlayerCorpse := preload("res://player/player_corpse.tscn")

@onready var music_player := $Audio/Music as AudioStreamPlayer
@onready var camera := $LevelCamera as Camera2D
@onready var finish := $Gameplay/FinishLine as FinishLine
@onready var player_camera_manager := $Logic/PlayerCameraManager as PlayerCameraManager
@onready var player_spawner := $Gameplay/PlayerSpawner as PlayerSpawner

@onready var container_players := $Players as Node2D

func _ready() -> void:
	if level_data:
		music_player.stream = level_data.music
		spawn_player()

func get_camera_position() -> Vector2:
	return camera.global_position

func get_length() -> float:
	return finish.position.x

func get_percentage() -> float:
	var x := player_camera_manager.get_highest_player_x()
	return x / get_length()

# Players

func add_player(player: Player):
	container_players.add_child(player)
	player.died.connect(_on_player_died)

func add_corpse(corpse_position: Vector2):
	var corpse := PlayerCorpse.instantiate() as PlayerCorpse
	corpse.position = corpse_position
	add_child(corpse)

func kill_all_players():
	for player in container_players.get_children():
		if player is Player:
			add_corpse(player.position)
			player.queue_free()

func spawn_player():
	player_spawner.start_respawning_player()
	await player_spawner.player_spawned
	music_player.play()

func respawn_player():
	player_camera_manager.wait_and_go_to_spawner()
	spawn_player()

func _on_player_died():
	kill_all_players()
	music_player.stop()
	
	respawn_player()
