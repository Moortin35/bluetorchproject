extends CanvasLayer

@onready var margin_container: MarginContainer = $MarginContainer

func resume():
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true
	show()

func press_pause():
	if Input.is_action_just_pressed("salir_menu") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("salir_menu") and get_tree().paused:
		resume()

func _on_button_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_button_continue_pressed() -> void:
	resume()
	
func _process(delta: float) -> void:
	press_pause()
	delta = delta
