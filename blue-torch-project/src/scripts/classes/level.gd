extends Node

class_name Level

@export var level_id : int

var level_data : LevelData

func _ready() -> void:
	level_data = LevelManager.get_level_by_id(level_id)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("salir_menu"):
		get_tree().reload_current_scene()
