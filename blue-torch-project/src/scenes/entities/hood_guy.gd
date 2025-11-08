extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const HOOD_GUY = preload("res://src/dialogues/dialogues_text/hood_guy.dialogue")
var is_player_close = false


func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	animated_sprite_2d.play("idle")

func _process(_delta: float) -> void:
	if is_player_close and Input.is_action_just_pressed("interact") and !DialogueManager.is_dialoge_active :
		DialogueManager.show_dialogue_balloon(HOOD_GUY)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.play_icon("talk")
		is_player_close = true
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.stop_icon()
		is_player_close = false
		
func _on_dialogue_started(dialogue):
	dialogue = dialogue
	DialogueManager.is_dialoge_active = true
	
func _on_dialogue_ended(dialogue):
	dialogue = dialogue
	await get_tree().create_timer(0.2).timeout
	DialogueManager.is_dialoge_active = false
	
	
