class_name FinishLine
extends Area2D

signal player_entered_finish()

var MainMenu: PackedScene

@onready var audio_player := $AudioStreamPlayer as AudioStreamPlayer
@onready var quit_timer := $QuitTimer as Timer

@onready var container_endscreen := $EndscreenUI/Container

func _ready() -> void:
	MainMenu = load("res://mainmenu/main_menu.tscn") as PackedScene

func show_endscreen():
	var tween := get_tree().create_tween()
	tween.tween_property(container_endscreen, ^"modulate", Color.WHITE, 1.0)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_entered_finish.emit()
		audio_player.play()
		quit_timer.start()
		show_endscreen()
		await quit_timer.timeout
		SceneManager.change_scene(MainMenu)
