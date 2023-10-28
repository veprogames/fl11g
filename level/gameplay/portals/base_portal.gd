class_name BasePortal
extends Area2D

func act(_player: Player) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		act(body)
