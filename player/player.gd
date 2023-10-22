class_name Player
extends CharacterBody2D

@onready var icon := $Icon as Node2D

const SPEED := 50.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity := ProjectSettings.get_setting("physics/2d/default_gravity") as float

@export var gravity_mod := 1.0
var size := 1.0

var x_correction := 0.0

func get_target_angle() -> float:
	if is_on_floor():
		return -get_floor_angle()
	return velocity.angle()

func _process(delta: float) -> void:
	icon.rotation += (get_target_angle() - icon.rotation) * delta * 10
	# icon.flip_v = gravity_mod < 0

func _physics_process(delta: float) -> void:
	# react to input
	var input_multiplier := -1.25 if Input.is_action_pressed("player_input") else 1.0
	
	# slope calculations
	var slope_degrees := rad_to_deg(absf(get_floor_angle()))
	var gamma = deg_to_rad(180.0 - 90.0 - slope_degrees)
	# 1/sin(gamma) = x/sin(90deg)
	# 1/sin(gamma) * sin(90deg) = x
	# x = 1/sin(gamma) * 1
	var slope_speed_mult = 1.0 / sin(gamma) if is_on_floor() and slope_degrees > 0 else 1.0
	
	velocity.x = SPEED * slope_speed_mult - x_correction * 10
	velocity.y += gravity * gravity_mod * input_multiplier * delta
	velocity.y = clampf(velocity.y, gravity * absf(gravity_mod) * -0.33, gravity * absf(gravity_mod) * 0.33)
	
	var prev_x = position.x
	
	move_and_slide()
	
	# account for errors
	var actual_movement = position.x - prev_x
	var wanted_movement = SPEED * delta
	x_correction += (actual_movement - wanted_movement)
	
	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		var collider := collision.get_collider() as TileMap
		if collider and collider.is_in_group("hazard"):
			queue_free()
		if collider and collider.is_in_group("tiles") and absf(collision.get_angle() - PI / 2) < 0.01:
			queue_free()
