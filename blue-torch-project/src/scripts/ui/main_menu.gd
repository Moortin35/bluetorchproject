extends Control

class_name MainMenu
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var animated_torch: AnimatedSprite2D = $AnimatedTorch
@onready var credits: CanvasLayer = $Credits

const MUSIC_MENU := preload("res://_assets/sounds/music/main_theme.mp3")
const SFX_UI_START := preload("res://_assets/sounds/effects/ui/start.wav")
const SFX_UI_ENTER := preload("res://_assets/sounds/effects/ui/enter.wav")
const SFX_UI_BACK := preload("res://_assets/sounds/effects/ui/back.wav")
const SFX_UI_HOVER := preload("res://_assets/sounds/effects/ui/hover.wav")

func _ready() -> void:
	AudioController.play_music(MUSIC_MENU)
	animated_torch.play()

func _on_button_mouse_entered() -> void:
	AudioController.play_sfx(SFX_UI_HOVER, "UI")
	
func _on_play_button_pressed() -> void:
	LevelManager.load_level(1)
	AudioController.play_sfx(SFX_UI_START, "UI")
	deactivate()

func _on_credits_button_pressed() -> void:
	AudioController.play_sfx(SFX_UI_ENTER, "UI")
	canvas_layer.hide()
	credits.show()

func _on_quit_button_pressed() -> void:
	AudioController.play_sfx(SFX_UI_ENTER, "UI")
	get_tree().quit()

func _on_back_button_pressed() -> void:
	AudioController.play_sfx(SFX_UI_BACK, "UI")
	credits.hide()
	canvas_layer.show()
	
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
