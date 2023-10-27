extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("game_quit"):
		SceneManager.quit_game()

func _on_button_quit_pressed() -> void:
	SceneManager.quit_game()
