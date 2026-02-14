extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var is_open = false

const SFX_GATE_OPEN := preload("res://_assets/sounds/sfx/environment/gate_open.wav")

func _ready() -> void:
	if is_open:
		collision_shape_2d.position.y = -42
		animated_sprite_2d.play("open_idle")
	else:
		collision_shape_2d.position.y = 0
		animated_sprite_2d.play("close_idle")
		

func close() -> void:
	collision_shape_2d.position.y = 0
	animated_sprite_2d.play("close")
	AudioController.play_sfx(SFX_GATE_OPEN, "Reverb")
	

func open() -> void:
	collision_shape_2d.position.y = -42
	animated_sprite_2d.play("open")
	AudioController.play_sfx(SFX_GATE_OPEN, "Reverb")
	


func _on_lever_pull_lever() -> void:
	if is_open:
		close()
		is_open = false
	else:
		open()
		is_open = true
