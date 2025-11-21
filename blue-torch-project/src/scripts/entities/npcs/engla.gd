extends interactive

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const ENGLA = preload("res://src/dialogues/es/engla.dialogue")

func _ready() -> void:
	super._ready()
	icon = "talk"
	animated_sprite_2d.play("idle")
	
func _process(_delta: float) -> void:
	if can_i_interact():
		AudioControler.play_aaa()
		DialogueManager.show_dialogue_balloon(ENGLA)
