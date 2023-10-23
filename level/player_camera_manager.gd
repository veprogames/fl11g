class_name PlayerCameraManager
extends Node2D

@export var camera: Camera2D
@export var player_container: Node2D
@export var target_spawner: PlayerSpawner

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_player := get_farthest_player()
	if target_player:
		camera.global_position = target_player.position

func wait_and_go_to_spawner():
	await get_tree().create_timer(0.5).timeout
	camera.global_position = target_spawner.global_position

func get_farthest_player() -> Player:
	var highest_x := 0.0
	var highest_player: Player
	for player in player_container.get_children():
		if player is Player and highest_x < player.global_position.x:
			highest_x = player.global_position.x
			highest_player = player
	return highest_player

func get_highest_player_x() -> float:
	var player := get_farthest_player()
	if player:
		return player.position.x
	return 0.0
