extends Control
@export var in_time: float = 0.5
@export var fade_in_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5

@onready var label_0: Label = $ColorRect/CenterContainer/Label0
@onready var logo: TextureRect = $ColorRect/CenterContainer/Logo
@onready var label_2: Label = $ColorRect/CenterContainer/Label2
@onready var label_3: Label = $ColorRect/CenterContainer/Label3
@onready var label_4: Label = $ColorRect/CenterContainer/Label4
@onready var label_5: Label = $ColorRect/CenterContainer/Label5
@onready var label_6: Label = $ColorRect/CenterContainer/Label6
@onready var label_7: Label = $ColorRect/CenterContainer/Label7

var can_skip: bool = true

func fade(screen : Control, pause_time : float) -> void:	
	if screen == null:
		push_error("El nodo pasado a fade() es nulo")
		return
	
	screen.visible = true	
	screen.modulate = Color(1, 1, 1, 0)
	
	var tween = create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(screen, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(screen, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	
	await tween.finished
	
	screen.visible = false
	
func _ready() -> void:

	
	label_0.visible = false
	logo.visible = false
	label_2.visible = false
	label_3.visible = false
	label_4.visible = false
	label_5.visible = false
	label_6.visible = false
	label_7.visible = false
	
	
	await fade(label_0, 2.0)
	await fade(logo, 2.0)
	await fade(label_2, 12.0)
	await fade(label_3, 12.0)
	await fade(label_4, 12.0)
	await fade(label_5, 12.0)
	await fade(label_6, 12.0)
	await fade(label_7, 12.0)
	
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")
	
func skip_to_main():
	if can_skip:
		can_skip = false  # Evitar múltiples llamadas
		get_tree().change_scene_to_file("res://src/scenes/main.tscn")

func _input(event):
	# Detectar cualquier tecla, clic o botón de gamepad
	if event.is_pressed():
		skip_to_main()
