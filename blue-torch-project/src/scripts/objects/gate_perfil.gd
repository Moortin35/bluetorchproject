extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	
	collision_shape_2d.position.y = -42

func _on_area_trigger_area_trigger() -> void:
	collision_shape_2d.position.y = 0
	animated_sprite_2d.play("close")
