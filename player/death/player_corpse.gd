class_name PlayerCorpse
extends Node2D

@onready var ship := $Ship as RigidBody2D
@onready var cube := $Cube as RigidBody2D
@onready var timer := $DespawnTimer as Timer

const BASE_FORCE = 70.0

func _ready() -> void:
	ship.apply_central_impulse(Vector2(randf_range(-BASE_FORCE, BASE_FORCE), -BASE_FORCE))
	cube.apply_central_impulse(Vector2(randf_range(-BASE_FORCE, BASE_FORCE), -BASE_FORCE))
	ship.apply_torque_impulse(BASE_FORCE)
	cube.apply_torque_impulse(BASE_FORCE)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, ^"modulate", Color.TRANSPARENT, timer.wait_time)

func _on_despawn_timer_timeout() -> void:
	queue_free()
