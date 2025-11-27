extends Node2D

@onready var animation_player: AnimationPlayer = $Plataform/AnimationPlayer
@export var animation : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if animation == "" or !animation_player.has_animation(animation):
		print("no existe la animación: ", animation)
	else:
		animation_player.play(animation)
