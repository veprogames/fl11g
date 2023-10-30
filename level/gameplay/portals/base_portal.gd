class_name BasePortal
extends Area2D

@onready var sprite: Sprite2D = $Sprite

func act(_player: Player) -> void:
	blink()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		act(body)

func blink() -> void:
	var tween := get_tree().create_tween()
	var current_modulate := sprite.modulate
	tween.tween_property(sprite, ^"modulate", Color.WHITE, 0.1).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, ^"modulate", current_modulate, 0.3).set_ease(Tween.EASE_OUT)
