extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.player_inventory.add_item("lever")
		queue_free()
