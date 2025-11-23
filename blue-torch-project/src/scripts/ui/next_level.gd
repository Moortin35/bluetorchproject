extends CanvasLayer

@onready var next_level: CanvasLayer = $"."


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	LevelManager.load_level(2)
	AudioControler.stop_music()
	AudioControler.play_lvl1()

func mostrar_menu():
	next_level.show()
	get_tree().paused = true
