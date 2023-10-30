class_name SizePortal
extends BasePortal

var size := 1.0

@export var size_gradient: Gradient

func _ready() -> void:
	size = scale.y
	sprite.modulate = size_gradient.sample(remap(size, 0.5, 2.0, 0.0, 1.0))

func act(player: Player) -> void:
	super.act(player)
	player.size = size
