extends Level

func _ready() -> void:
	super._ready()
	level_data = LevelManager.get_level_by_id(level_id)
	player.camera_2d.limit_right = 1296
	player.camera_2d.limit_bottom =736
	player.camera_2d.limit_left = -816
	player.camera_2d.limit_top = -670
	
