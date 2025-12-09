extends Level

func _ready() -> void:
	level_data = LevelManager.get_level_by_id(level_id)
	player.camera_2d.limit_right = 336
	player.camera_2d.limit_bottom =176
	player.camera_2d.limit_left = -416


func _on_area_trigger_area_trigger() -> void:
	var tween := create_tween()
	tween.tween_property(player.camera_2d, "limit_left", -16, 0.5) # 1 segundo de transición
