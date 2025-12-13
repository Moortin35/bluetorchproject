extends Control
@export var in_time: float = 0.5
@export var fade_in_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5

@onready var label_0: Label = $ColorRect/CenterContainer/Label0
@onready var label_1: Label = $ColorRect/CenterContainer/Label1
@onready var label_2: Label = $ColorRect/CenterContainer/Label2
@onready var label_3: Label = $ColorRect/CenterContainer/Label3
@onready var label_4: Label = $ColorRect/CenterContainer/Label4

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
	label_1.visible = false
	label_2.visible = false
	label_3.visible = false
	label_4.visible = false
	
	await fade(label_0, 2.0)
	await fade(label_1, 2.0)
	await fade(label_2, 10.0)
	await fade(label_3, 10.0)
	await fade(label_4, 10.0)
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")
	
func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://main.tscn")
