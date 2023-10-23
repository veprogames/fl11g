class_name FinishLine
extends Area2D

@onready var audio_player := $AudioStreamPlayer as AudioStreamPlayer
@onready var quit_timer := $QuitTimer as Timer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		audio_player.play()
		quit_timer.start()
		await quit_timer.timeout
		get_tree().quit()
