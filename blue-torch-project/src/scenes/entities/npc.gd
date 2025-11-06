extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play("idle")

func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interactions.play("mouth")
		body.interactions.show()
		


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interactions.hide()
