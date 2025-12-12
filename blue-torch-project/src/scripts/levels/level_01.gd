extends Level
@onready var gate_perfil: Node2D = $gate_perfil
#pos_fall_maiden (-720, 388)

func _ready() -> void:
	super._ready()
	level_data = LevelManager.get_level_by_id(level_id)
	player.camera_2d.limit_right = 1296
	player.camera_2d.limit_bottom =736
	player.camera_2d.limit_left = -816
	player.camera_2d.limit_top = -670
	


func _on_fire_bowl_i_finished() -> void:
	gate_perfil.open()
