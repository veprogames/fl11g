@tool
class_name LevelGuidelines
extends Node2D

const LINE_WIDTH := 2.0

@export var data: LevelGuidelineData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if Engine.is_editor_hint() and data != null:
		for x in data.lines:
			draw_line(Vector2(x + LINE_WIDTH * 0.5, -100000), Vector2(x + LINE_WIDTH - 0.5, 100000), Color.ORANGE_RED, LINE_WIDTH)
		for guideline in data.speed_lines:
			var x := guideline.x
			var speed := guideline.speed_level
			draw_line(Vector2(x + LINE_WIDTH * 0.5, -100000), Vector2(x + LINE_WIDTH - 0.5, 100000), Color.WHITE_SMOKE, LINE_WIDTH)
			draw_string(ThemeDB.fallback_font, Vector2(x + LINE_WIDTH * 3, 0), "x%d" % speed, HORIZONTAL_ALIGNMENT_LEFT, -1, 36)
