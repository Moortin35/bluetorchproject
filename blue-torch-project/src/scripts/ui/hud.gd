extends CanvasLayer

@onready var margin_container: MarginContainer = %MarginContainer

func _on_exit_button_pressed() -> void:
	get_tree().reload_current_scene()

func mostrar_menu():
	margin_container.show()
