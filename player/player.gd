class_name Player
extends CharacterBody2D

@onready var icon := $Icon as Node2D

const SPEED := 90.0
const COLLISION_LAYER_BLOCKS = 0b10
const COLLISION_LAYER_HAZARD = 0b100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float

@export var gravity_mod := 1.0
@export var size := 1.0

var x_correction := 0.0

func get_target_angle() -> float:
	if is_on_floor():
		return -get_floor_angle()
	return velocity.angle()

func _process(delta: float) -> void:
	icon.rotation += (get_target_angle() - icon.rotation) * delta * 10
	icon.scale.y = -1 if gravity_mod < 0 else 1

func get_slope_speed_multiplier(slope_degrees: float) -> float:
	var gamma = deg_to_rad(180.0 - 90.0 - slope_degrees)
	# 1/sin(gamma) = x/sin(90deg)
	# 1/sin(gamma) * sin(90deg) = x
	# x = 1/sin(gamma) * 1
	return 1.0 / sin(gamma) if is_on_floor() and slope_degrees > 0 else 1.0

func _physics_process(delta: float) -> void:
	# react to input
	var input_multiplier := -1.25 if Input.is_action_pressed("player_input") else 1.0
	
	# slope calculations
	var slope_degrees := rad_to_deg(absf(get_floor_angle()))
	var slope_speed_mult = get_slope_speed_multiplier(slope_degrees)
	
	velocity.x = SPEED * slope_speed_mult - x_correction * 10
	velocity.y += gravity * gravity_mod * input_multiplier * delta
	velocity.y = clampf(velocity.y, gravity * absf(gravity_mod) * -0.33, gravity * absf(gravity_mod) * 0.33)
	
	var prev_x = position.x
	
	move_and_slide()
	
	# account for deviations in x movement
	# correct x movement over time to sync with music
	var actual_movement = position.x - prev_x
	var wanted_movement = SPEED * delta
	x_correction += (actual_movement - wanted_movement)
	
	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		var collider := collision.get_collider() as TileMap
		if collider:
			var rid = collision.get_collider_rid()
			var layer = PhysicsServer2D.body_get_collision_layer(rid)

			#if layer == COLLISION_LAYER_BLOCKS and is_equal_approx(absf(collision.get_angle()), PI / 2):
			if layer == COLLISION_LAYER_BLOCKS and (absf(collision.get_angle() - PI / 2)) < PI / 4:
				queue_free()
			if layer == COLLISION_LAYER_HAZARD:
				queue_free()
