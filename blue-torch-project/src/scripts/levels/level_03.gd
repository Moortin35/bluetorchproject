extends Level

@onready var gate_perfil: Node2D = $gate_perfil
@onready var boss: CharacterBody2D = $Boss



func _ready() -> void:
	super._ready()
	level_data = LevelManager.get_level_by_id(level_id)
	player.camera_2d.limit_right = 336
	player.camera_2d.limit_bottom =176
	player.camera_2d.limit_left = -416


func _on_area_trigger_area_trigger() -> void:
	var tween := create_tween()
	tween.tween_property(player.camera_2d, "limit_left", -16, 0.5)
	gate_perfil.close()
	boss.state_machine.change_to('idle')
	
