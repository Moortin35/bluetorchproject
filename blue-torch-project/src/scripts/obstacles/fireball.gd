extends Node2D

@export var speed: float = 300.0
@export var max_distance: float = 600.0
var start_position: Vector2


func _process(delta: float) -> void:
	position.x += speed * delta

	if abs(global_position.x - start_position.x) >= max_distance:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1.0, self)
		queue_free()
