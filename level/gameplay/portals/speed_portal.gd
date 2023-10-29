class_name SpeedPortal
extends BasePortal

@export var speed_level := 0
@export var speed_gradient: Gradient

@onready var sprite: Sprite2D = $Sprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	var gradient_pos := remap(speed_level, -10.0, 10.0, 0.0, 1.0)
	sprite.modulate = speed_gradient.sample(clampf(gradient_pos, 0.0, 1.0))
	if speed_level >= 0:
		sprite.region_rect.size.x = 8 * (speed_level + 1)
		sprite.scale.x = min(1.0, 1.5 / (1 + 0.2 * (speed_level + 1)))
	else:
		sprite.region_rect.size.x = 8 * absf(speed_level)
		sprite.scale.x = -min(1.0, 1.5 / (1 + 0.2 * absf(speed_level)))
	
	# adjust collision box
	var new_shape = collision_shape_2d.shape.duplicate() as RectangleShape2D
	# original region rect width was 8
	var sprite_scaled_by := (sprite.region_rect.size.x / 8.0) * absf(sprite.scale.x)
	if new_shape:
		new_shape.size.x *= sprite_scaled_by
		collision_shape_2d.shape = new_shape

func act(player: Player) -> void:
	player.speed_level = speed_level
