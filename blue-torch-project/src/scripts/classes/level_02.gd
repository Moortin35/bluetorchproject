extends Level

func _ready() -> void:
	level_data = LevelManager.get_level_by_id(level_id)
	player.camera_2d.limit_right = 3000
	player.camera_2d.limit_bottom =3000
	player.camera_2d.limit_left = -3000
	player.camera_2d.limit_top = -3000
