extends CanvasLayer


func _on_exit_button_pressed() -> void:
	get_tree().reload_current_scene()
