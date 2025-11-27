extends Node2D

@onready var animation_player: AnimationPlayer = $Plataform/AnimationPlayer
@export var animation : String = ""
@export var _id : int = 0
@export var _on = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.the_lever_moved.connect(_on_elevator)
	if _on:
		animation_player.play(animation)
	
	
func _on_elevator(id,on):
	if _id == id:	
		if on:
			if animation == "" or !animation_player.has_animation(animation):
				print("no existe la animación: ", animation)
			else:
				animation_player.play(animation)
		else:
			animation_player.pause()
