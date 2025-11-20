extends Node2D

@export var open : bool = false
@onready var door_sprites: AnimatedSprite2D = $DoorSprites
@onready var collision_shape_close: CollisionShape2D = $StaticBody2D/CollisionShapeClose
@onready var collision_shape_open: CollisionShape2D = $StaticBody2D/CollisionShapeOpen
@onready var open_door: Sprite2D = $OpenDoor

func _process(delta: float) -> void:
	if open:
		door_sprites.play("open")
		collision_shape_close.disabled = true
		open_door.show()
		
	else:
		door_sprites.play("close")
		collision_shape_close.disabled = false
		open_door.hide()
