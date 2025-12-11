extends CanvasLayer

@onready var exit_door: Area2D = $".."


func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	LevelManager.load_level(exit_door.level_to_pass)
	AudioControler.stop_music()
	AudioControler.play_lvl1()


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("interact"):
		_on_next_level_button_pressed()
