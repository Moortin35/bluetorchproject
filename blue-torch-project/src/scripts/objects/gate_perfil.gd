extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var is_open = true

func _ready() -> void:
	if is_open:
		collision_shape_2d.position.y = -42
		animated_sprite_2d.play("open_idle")
	else:
		collision_shape_2d.position.y = 0
		animated_sprite_2d.play("cloese_idle")

func close() -> void:
	collision_shape_2d.position.y = 0
	animated_sprite_2d.play("close")

func open() -> void:
	collision_shape_2d.position.y = -42
	animated_sprite_2d.play("open")
