extends Area2D

@onready var hud: CanvasLayer = $"../Hud"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		hud.mostrar_menu()
