extends Control

class_name MainMenu
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animated_torch: AnimatedSprite2D = $AnimatedTorch
@onready var credits: CanvasLayer = $Credits


func _ready() -> void:
	AudioControler.play_music()
	AudioControler.stop_lvl_music()
	animated_torch.play()

func _on_play_button_pressed() -> void:
	LevelManager.load_level(1)
	AudioControler.stop_music()
	deactivate()

func _on_credits_button_pressed() -> void:
	canvas_layer.hide()
	credits.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func deactivate() -> void:
	hide()
	canvas_layer.hide()
	set_process(false)
	set_process_unhandled_input(false)
	set_process_input(false)
	set_physics_process(false)


func activate() -> void:
	show()
	set_process(true)
	set_process_unhandled_input(true)
	set_process_input(true)
	set_physics_process(true)

#Credits

func _on_back_button_pressed() -> void:
	credits.hide()
	canvas_layer.show()
