extends Area2D

@export var icon: String
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.play_icon(icon)

		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.stop_icon()
