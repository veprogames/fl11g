extends TextureRect

@export var color_top: Color
@export var color_bottom: Color
@export var scroll: float

@export var level: Level

@onready var shader_material = material as ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if shader_material:
		shader_material.set_shader_parameter("color_top", color_top)
		shader_material.set_shader_parameter("color_bottom", color_bottom)
		shader_material.set_shader_parameter("scroll", scroll)

func _process(_delta: float) -> void:
	set_scroll(level.get_camera_position().x / 1500.0)

func set_scroll(_scroll: float) -> void:
	scroll = _scroll
	if shader_material:
		shader_material.set_shader_parameter("scroll", scroll)
