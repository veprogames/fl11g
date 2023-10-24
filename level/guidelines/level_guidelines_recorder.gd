extends Node2D

# needed to get focused player x
@export var player_manager: PlayerCameraManager
@export var recording := false
@export var file_name_extra := ""

var data := LevelGuidelineData.new()

func is_recording() -> bool:
	return recording and OS.is_debug_build()

func is_empty() -> bool:
	return len(data.lines) == 0

func save() -> void:
	var filename := "res://recorded_guidelines/guidelines-%s-%s.tres" % [file_name_extra, Time.get_time_string_from_system()]
	ResourceSaver.save(data, filename)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_recording():
		if Input.is_action_just_pressed("guidelines_add_line"):
			data.add_line(player_manager.get_highest_player_x())
		if Input.is_action_just_pressed("guidelines_save"):
			save()

func _exit_tree() -> void:
	if is_recording() and not is_empty():
		save()
