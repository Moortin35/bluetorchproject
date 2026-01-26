extends CanvasLayer

@onready var margin_container: MarginContainer = $MarginContainer

const SFX_UI_START := preload("res://_assets/sounds/sfx/ui/start.wav")
const SFX_UI_ENTER := preload("res://_assets/sounds/sfx/ui/enter.wav")
const SFX_UI_BACK := preload("res://_assets/sounds/sfx/ui/back.wav")
const SFX_UI_HOVER := preload("res://_assets/sounds/sfx/ui/hover.wav")

func resume():
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true
	show()

func press_pause():
	if Input.is_action_just_pressed("salir_menu") and !get_tree().paused:
		pause()
		AudioController.play_sfx(SFX_UI_BACK, "UI")
	elif Input.is_action_just_pressed("salir_menu") and get_tree().paused:
		resume()

func _on_button_mouse_entered() -> void:
	AudioController.play_sfx(SFX_UI_HOVER, "UI")

func _on_button_continue_pressed() -> void:
	AudioController.play_sfx(SFX_UI_ENTER, "UI")
	resume()

func _on_button_restart_pressed() -> void:
	var actual_level = LevelManager.loaded_level.level_id
	AudioController.play_sfx(SFX_UI_ENTER, "UI")
	LevelManager.load_level(actual_level)
	get_tree().paused = false

func _on_button_exit_pressed() -> void:
	AudioController.play_sfx(SFX_UI_ENTER, "UI")
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _process(delta: float) -> void:
	press_pause()
	delta = delta
