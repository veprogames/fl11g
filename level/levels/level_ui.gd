extends CanvasLayer

@export var level: Level
@onready var progress_bar := $ProgressBar as ProgressBar

var highest_progress_yet := 0.0

func _ready() -> void:
	level.player_respawned.connect(_on_player_respawned)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	highest_progress_yet = maxf(highest_progress_yet, level.get_percentage())
	progress_bar.value = highest_progress_yet

func _on_player_respawned() -> void:
	highest_progress_yet = 0
