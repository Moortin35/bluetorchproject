extends CanvasLayer

@onready var margin_container: MarginContainer = %MarginContainer


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	LevelManager.load_level(2)
	AudioControler.stop_music()
	AudioControler.play_lvl1()

func mostrar_menu():
	margin_container.show()
	get_tree().paused = true
