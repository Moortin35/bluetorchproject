extends CanvasLayer

func _on_end_test_button_pressed() -> void:
	AudioControler.stop_music()
	get_tree().paused = false
	get_tree().reload_current_scene()
