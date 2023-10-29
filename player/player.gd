class_name Player
extends CharacterBody2D

signal died()

@onready var icon := $Icon as Node2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var collision_shape: CircleShape2D

const BASE_SPEED := 90.0
const COLLISION_LAYER_BLOCKS = 0b10
const COLLISION_LAYER_HAZARD = 0b100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float

@export var speed_level := 0
@export var gravity_mod := 1.0
@export var size := 1.0 : set = _set_size, get = _get_size

var x_correction := 0.0
var has_died := false
var base_collision_circle_size: float

func _get_size() -> float:
	return size

func _set_size(new_size: float) -> void:
	size = new_size
	icon.scale = Vector2.ONE * new_size
	collision_shape.radius = base_collision_circle_size * new_size

func _ready() -> void:
	# setup collision shape
	# needs to be duplicated to its own reference
	# so multiple players can be handled
	collision_shape = collision_shape_2d.shape as CircleShape2D
	if collision_shape:
		base_collision_circle_size = collision_shape.radius
		var new_collision_shape := collision_shape.duplicate()
		collision_shape = new_collision_shape
		collision_shape_2d.shape = new_collision_shape

func _process(delta: float) -> void:
	icon.rotation += (get_target_angle() - icon.rotation) * delta * 10
	#icon.scale.y = -1 if gravity_mod < 0 else 1

func get_target_angle() -> float:
	if is_on_floor():
		return -get_floor_angle()
	return velocity.angle()

func get_slope_speed_multiplier(slope_degrees: float) -> float:
	var gamma = deg_to_rad(180.0 - 90.0 - slope_degrees)
	# 1/sin(gamma) = x/sin(90deg)
	# 1/sin(gamma) * sin(90deg) = x
	# x = 1/sin(gamma) * 1
	return 1.0 / sin(gamma) if is_on_floor() and slope_degrees > 0 else 1.0

func get_max_velocity_y() -> float:
	return gravity * absf(gravity_mod) / size * 0.33

func get_x_velocity() -> float:
	return BASE_SPEED * pow(1.25, speed_level)

func died_to_block(layer: int, collision: KinematicCollision2D) -> bool:
	# this angle * 2 -> angle range where player dies
	const COLLISION_TOLERANCE = PI / 6
	return layer == COLLISION_LAYER_BLOCKS and (absf(collision.get_angle() - PI / 2)) < COLLISION_TOLERANCE

func died_to_hazard(layer: int) -> bool:
	return layer == COLLISION_LAYER_HAZARD

func die() -> void:
	died.emit()
	has_died = true

func _physics_process(delta: float) -> void:
	# react to input
	var input_multiplier := -1.25 if Input.is_action_pressed("player_input") else 1.0
	
	# size modifier: smaller -> fly up/down quicker
	input_multiplier /= size
	
	# gravity modifier
	input_multiplier *= gravity_mod
	
	# slope calculations
	var slope_degrees := rad_to_deg(absf(get_floor_angle()))
	var slope_speed_mult = get_slope_speed_multiplier(slope_degrees)
	
	# max y speed
	var max_y_velocity := get_max_velocity_y()
	
	var x_velocity := get_x_velocity()
	
	velocity.x = x_velocity * slope_speed_mult - x_correction * 10
	velocity.y += gravity * input_multiplier * delta
	velocity.y = clampf(velocity.y, -max_y_velocity, max_y_velocity)
	
	var prev_x = position.x
	
	move_and_slide()
	
	# account for deviations in x movement
	# correct x movement over time to sync with music
	var actual_movement = position.x - prev_x
	var wanted_movement = x_velocity * delta
	x_correction += (actual_movement - wanted_movement)
	
	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		var collider := collision.get_collider() as TileMap
		if collider:
			var rid = collision.get_collider_rid()
			var layer = PhysicsServer2D.body_get_collision_layer(rid)

			var will_die = died_to_block(layer, collision) or died_to_hazard(layer)
			if not has_died and will_die:
				die()
