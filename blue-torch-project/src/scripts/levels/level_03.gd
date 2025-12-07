extends Level

func _ready() -> void:
	level_data = LevelManager.get_level_by_id(level_id)
	player.camera_2d.limit_right = 336
	player.camera_2d.limit_bottom =176
