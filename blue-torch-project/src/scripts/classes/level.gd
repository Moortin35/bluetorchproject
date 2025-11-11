extends Node

class_name Level

@export var level_id : int
@onready var player: Player = $Player
@export var START_POS_LEVEL : Vector2

var level_data : LevelData
