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

func set_size(size: float) -> void:
	# rescale every child of every rigidbody2d
	# as rigidbodies can't be scaled on their own
	for child in [ship, cube]:
		for sub_child in child.get_children():
			var sprite := sub_child as Sprite2D
			var collision_shape := sub_child as CollisionShape2D
			if sprite:
				sprite.scale = Vector2.ONE * size
			if collision_shape:
				var new_shape := collision_shape.shape.duplicate() as RectangleShape2D
				if new_shape:
					new_shape.size *= size
					collision_shape.shape = new_shape

func _on_despawn_timer_timeout() -> void:
	queue_free()
