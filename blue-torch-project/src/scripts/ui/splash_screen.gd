extends Control
@export var in_time: float = 0.5
@export var fade_in_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5
@onready var label_0: Label = $ColorRect/MarginContainer/CenterContainer/Label0
@onready var skip_label: Label = $ColorRect/MarginContainer/SkipLabel
@onready var logo: TextureRect = $ColorRect/MarginContainer/CenterContainer/Logo
@onready var label_2: Label = $ColorRect/MarginContainer/CenterContainer/Label2
@onready var label_3: Label = $ColorRect/MarginContainer/CenterContainer/Label3
@onready var label_4: Label = $ColorRect/MarginContainer/CenterContainer/Label4
@onready var label_5: Label = $ColorRect/MarginContainer/CenterContainer/Label5
@onready var label_6: Label = $ColorRect/MarginContainer/CenterContainer/Label6
@onready var label_7: Label = $ColorRect/MarginContainer/CenterContainer/Label7

const MUSIC_MENU := preload("res://_assets/sounds/music/main_theme.mp3")

var can_skip: bool = true
var current_tween: Tween = null
var skip_current: bool = false
var esc_press_time: float = 0.0

func fade(screen : Control, pause_time : float) -> void:	
	if screen == null:
		push_error("El nodo pasado a fade() es nulo")
		return
	
	screen.visible = true	
	screen.modulate = Color(1, 1, 1, 0)
	
	current_tween = create_tween()
	current_tween.tween_interval(in_time)
	current_tween.tween_property(screen, "modulate:a", 1.0, fade_in_time)
	current_tween.tween_interval(pause_time)
	current_tween.tween_property(screen, "modulate:a", 0.0, fade_out_time)
	current_tween.tween_interval(out_time)
	
	await current_tween.finished
	
	if skip_current:
		skip_current = false
		screen.modulate = Color(1, 1, 1, 0)
	
	screen.visible = false
	current_tween = null
	
func _ready() -> void:
	set_process_input(true)
	
	label_0.visible = false
	skip_label.visible = false
	logo.visible = false
	label_2.visible = false
	label_3.visible = false
	label_4.visible = false
	label_5.visible = false
	label_6.visible = false
	label_7.visible = false
	
	AudioController.play_music(MUSIC_MENU)
	
	
	await fade(label_0, 2.0)
	if skip_current: return
	await fade(logo, 2.0)
	if skip_current: return
	fade(skip_label, 4.0)
	await fade(label_2, 12.0)
	if skip_current: return
	await fade(label_3, 12.0)
	if skip_current: return
	await fade(label_4, 12.0)
	if skip_current: return
	await fade(label_5, 12.0)
	if skip_current: return
	await fade(label_6, 12.0)
	if skip_current: return
	await fade(label_7, 12.0)
	
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")

func _process(delta: float) -> void:
	if Input.is_action_pressed("salir_menu"):
		esc_press_time += delta
		if esc_press_time >= 1.5:
			skip_to_main()
	else:
		esc_press_time = 0.0
	
func skip_current_label():
	if current_tween and current_tween.is_valid():
		current_tween.set_speed_scale(1000.0)
		
func skip_to_main():
	if can_skip:
		can_skip = false
		if current_tween and current_tween.is_valid():
			current_tween.kill()
		get_tree().change_scene_to_file("res://src/scenes/main.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		skip_current_label()
