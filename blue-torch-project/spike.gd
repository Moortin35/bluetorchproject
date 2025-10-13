extends Node2D
class_name Spike

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $DangerZone/CollisionShape2D
@export var size: int = 1

func _ready() -> void:
	randomize()

	sprite_2d.hframes = 6
	sprite_2d.vframes = 1

	# Duplicar los sprites según el tamaño
	for i in range(size):
		var sprite: Sprite2D = sprite_2d.duplicate()
		sprite.frame = randi_range(0, (sprite_2d.hframes * sprite_2d.vframes) - 1)
		sprite.position.x = 16 * i
		add_child(sprite)

	# Asegurar que la forma de colisión sea única para este nodo
	if collision_shape_2d.shape:
		var shape = collision_shape_2d.shape.duplicate()
		if shape is RectangleShape2D:
			shape.size.x = 16 * size
		collision_shape_2d.shape = shape

	# Reposicionar el CollisionShape2D al centro del conjunto de spikes
	collision_shape_2d.position.x = (collision_shape_2d.shape.size.x / 2) - 8
		
