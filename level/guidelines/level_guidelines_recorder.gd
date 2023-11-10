extends Node2D

# needed to get focused player x
@export var player_manager: PlayerCameraManager
@export var recording := false
@export var file_name_extra := ""

var data := LevelGuidelineData.new()

func is_recording() -> bool:
	return recording and OS.is_debug_build()

func is_empty() -> bool:
	return len(data.lines) == 0 and len(data.speed_lines) == 0

func save() -> void:
	var filename := "res://recorded_guidelines/guidelines-%s-%s.tres" % [file_name_extra, Time.get_time_string_from_system()]
	ResourceSaver.save(data, filename)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_recording():
		var x := player_manager.get_highest_player_x()
		var player := player_manager.get_farthest_player()
		
		if Input.is_action_just_pressed("guidelines_add_line"):
			data.add_line(x)
		
		if Input.is_action_just_pressed("guidelines_speed_-1"):
			player.speed_level = -1
			data.add_speed_line(x, -1)
		if Input.is_action_just_pressed("guidelines_speed_0"):
			player.speed_level = 0
			data.add_speed_line(x, 0)
		if Input.is_action_just_pressed("guidelines_speed_1"):
			player.speed_level = 1
			data.add_speed_line(x, 1)
		if Input.is_action_just_pressed("guidelines_speed_2"):
			player.speed_level = 2
			data.add_speed_line(x, 2)
		if Input.is_action_just_pressed("guidelines_speed_plus"):
			player.speed_level += 1
			data.add_speed_line(x, player.speed_level)
		if Input.is_action_just_pressed("guidelines_speed_minus"):
			player.speed_level -= 1
			data.add_speed_line(x, player.speed_level)
		
		if Input.is_action_just_pressed("guidelines_save"):
			save()

func _exit_tree() -> void:
	if is_recording() and not is_empty():
		save()
