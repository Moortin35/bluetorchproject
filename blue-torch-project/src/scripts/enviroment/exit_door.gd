extends Area2D

@onready var next_level: CanvasLayer = $"../NextLevel"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		next_level.mostrar_menu()
