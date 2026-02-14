extends CanvasLayer

const SFX_PLAYER_STEP = preload("res://_assets/sounds/sfx/characters/player_step_01.wav")
const SFX_DIALOGUE = preload("res://_assets/sounds/sfx/dialogue/dialogue_default_01.wav")
const SFX_UI_HOVER = preload("res://_assets/sounds/sfx/ui/hover.wav")

@onready var music_volume_slider = $MarginContainer/VBoxContainer/AudioControls/Music/Slider
@onready var sfx_volume_slider = $MarginContainer/VBoxContainer/AudioControls/SFX/Slider
@onready var dialogue_volume_slider = $MarginContainer/VBoxContainer/AudioControls/Dialogue/Slider
@onready var master_volume_slider = $MarginContainer/VBoxContainer/AudioControls/Master/Slider
@onready var ui_volume_slider = $MarginContainer/VBoxContainer/AudioControls/UI/Slider

func _ready() -> void:
	music_volume_slider.value = db_to_linear(AudioController.music_bus_volume)
	master_volume_slider.value = db_to_linear(AudioController.master_bus_volume)
	sfx_volume_slider.value = db_to_linear(AudioController.sfx_bus_volume)
	dialogue_volume_slider.value = db_to_linear(AudioController.dialogue_bus_volume)
	ui_volume_slider.value = db_to_linear(AudioController.ui_bus_volume)
	
func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioController.set_master_volume(linear_to_db(value))
	
func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioController.set_music_volume(linear_to_db(value))
	
func _on_sfx_volume_slider_value_changed(value: float) -> void:
	AudioController.set_sfx_volume(linear_to_db(value))
	if (visible):
		AudioController.play_sfx(SFX_PLAYER_STEP, "SFX")
	
func _on_dialogue_volume_slider_value_changed(value: float) -> void:
	AudioController.set_dialogue_volume(linear_to_db(value))
	if (visible):
		AudioController.play_sfx(SFX_DIALOGUE, "Dialogue")
	
func _on_ui_volume_slider_value_changed(value: float) -> void:
	AudioController.set_ui_volume(linear_to_db(value))
	if (visible):
		AudioController.play_sfx(SFX_UI_HOVER, "UI")
