class_name GravityPortal
extends BasePortal

enum GravityMode {
	SET,
	INVERT,
}

@export var gravity_mod := 1.0
@export var mode := GravityMode.SET

func _ready() -> void:
	if gravity_mod > 0.0:
		sprite.modulate = Color.DEEP_SKY_BLUE
	elif gravity_mod < 0.0:
		sprite.modulate = Color.YELLOW
	else:
		sprite.modulate = Color.PINK
	
	if mode == GravityMode.INVERT:
		sprite.modulate = Color.GREEN

func act(player: Player) -> void:
	if mode == GravityMode.INVERT:
		player.gravity_mod *= -1
	else:
		player.gravity_mod = gravity_mod
