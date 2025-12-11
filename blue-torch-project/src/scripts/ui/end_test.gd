extends CanvasLayer

func _on_end_test_button_pressed() -> void:
	AudioControler.stop_lvl_music()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("interact"):
		_on_end_test_button_pressed()
