extends CanvasLayer

@onready var margin_container: MarginContainer = $MarginContainer

func _on_button_exit_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_button_continue_pressed() -> void:
	margin_container.hide()


func _on_visibility_changed() -> void:
	margin_container.show()
