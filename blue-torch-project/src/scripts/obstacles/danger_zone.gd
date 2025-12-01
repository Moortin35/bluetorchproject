extends Area2D

@onready var is_lethal = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if is_lethal:
			body.handle_danger()
		else:
			body.take_damage(1,self)
