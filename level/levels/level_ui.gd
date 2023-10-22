extends CanvasLayer

@export var level: Level
@onready var progress_bar := $ProgressBar as ProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	progress_bar.value = level.get_percentage()
