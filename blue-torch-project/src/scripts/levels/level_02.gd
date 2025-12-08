extends Level

func _ready() -> void:
	level_data = LevelManager.get_level_by_id(level_id)
	player.camera_2d.limit_right = 1792
	player.camera_2d.limit_bottom =736
	player.camera_2d.limit_left = -1280
	player.camera_2d.limit_top = -240
