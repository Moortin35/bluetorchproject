extends Area2D

@onready var end_test: CanvasLayer = $"../EndTest"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		end_test.mostrar_menu()
