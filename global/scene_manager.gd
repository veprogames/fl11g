extends Node

@onready var rect := $Overlay/ColorRect as ColorRect

func change_scene(to: PackedScene) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(rect, ^"color", Color.BLACK, 0.3)
	tween.tween_callback(func(): _goto(to))
	tween.tween_property(rect, ^"color", Color(Color.BLACK, 0), 0.3)

func quit_game():
	var tween := get_tree().create_tween()
	tween.tween_property(rect, ^"color", Color.BLACK, 0.3)
	tween.tween_callback(func(): get_tree().quit())

func _goto(to: PackedScene):
	get_tree().change_scene_to_packed(to)
