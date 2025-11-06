extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const HOOD_GUY = preload("res://src/dialogues/dialogues_text/hood_guy.dialogue")
var is_player_close = false


func _ready() -> void:
	animated_sprite_2d.play("idle")

func _process(_delta: float) -> void:
	if is_player_close and Input.is_action_just_pressed("interact"):
		DialogueManager.show_dialogue_balloon(HOOD_GUY)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.interactions.play("mouth")
		body.interactions.show()
		is_player_close = true
		


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.interactions.hide()
		is_player_close
		is_player_close = false
		
