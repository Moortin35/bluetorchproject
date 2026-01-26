extends interactive

@export var open : bool = false
@onready var door_sprites: AnimatedSprite2D = $DoorSprites
@onready var collision_shape_close: CollisionShape2D = $StaticBody2D/CollisionShapeClose
@onready var collision_shape_open: CollisionShape2D = $StaticBody2D/CollisionShapeOpen
@onready var open_door: Sprite2D = $OpenDoor
const CLOSE_DOOR = preload("res://src/dialogues/es/close_door.dialogue")
@onready var interactive_area: CollisionShape2D = $InteractiveArea
var talk_finished : bool = false

const SFX_OPEN_DOOR := preload("res://_assets/sounds/effects/door_and_key_open.mp3")

func _ready():
	super._ready()
	icon = "key"
	if open:
		o_door()
	else:
		c_door()


func _process(_delta: float) -> void:
	if can_i_interact() and player != null: 
		if player.player_inventory.do_i_have("key"):
			player.player_inventory.remove_item("key")
			o_door()
		else:
			if !talk_finished:
				DialogueManager.show_dialogue_balloon(CLOSE_DOOR, "start")
				talk_finished = true
			else:
				DialogueManager.show_dialogue_balloon(CLOSE_DOOR, "finish_talk")

func o_door():
	door_sprites.play("open")
	interactive_area.disabled = true
	collision_shape_close.disabled = true
	open_door.show()
	AudioController.play_sfx(SFX_OPEN_DOOR, "Reverb")
	
func c_door():
	door_sprites.play("close")
	interactive_area.disabled = false
	collision_shape_close.disabled = false
	open_door.hide()
