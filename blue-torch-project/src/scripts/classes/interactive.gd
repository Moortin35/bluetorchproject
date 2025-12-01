extends Area2D

class_name interactive

@onready var icon : String
@onready var is_player_close = false
@onready var player = null
@onready var show_icon = true

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player and show_icon:
		body.play_icon(icon)
		is_player_close = true
		player = body
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.stop_icon()
		is_player_close = false
		player = null
		
func _on_dialogue_started(dialogue):
	dialogue = dialogue
	DialogueManager.is_dialoge_active = true
	
func _on_dialogue_ended(dialogue):
	dialogue = dialogue
	await get_tree().create_timer(0.2).timeout
	DialogueManager.is_dialoge_active = false
	
func can_i_interact():
	return is_player_close and Input.is_action_just_pressed("interact") and !DialogueManager.is_dialoge_active
