extends Node

class_name Level

@export var level_id : int

@onready var pause_menu: CanvasLayer = $PauseMenu

var level_data : LevelData

func _ready() -> void:
	level_data = LevelManager.get_level_by_id(level_id)

func _process(delta: float) -> void:
	delta = delta #para que no salte el error del depurador
	if Input.is_action_just_pressed("salir_menu"):
		pause_menu._on_visibility_changed()

func _on_pause_menu_visibility_changed() -> void:
	pass # Replace with function body.
