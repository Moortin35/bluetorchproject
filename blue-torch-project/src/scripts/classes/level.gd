extends Node

class_name Level

@export var level_id : int
@onready var player: Player = $Player
@export var START_POS_LEVEL : Vector2
@export var full_reset = false
@export var music_level :AudioStream

var level_data : LevelData

func _ready() -> void:
	if music_level != null:
		AudioControler.play_lvl_music(music_level)

func reset_lvl():
	if full_reset:
		LevelManager.load_level(level_id)
	else:
		if music_level != null:
			AudioControler.play_lvl_music(music_level)
		
