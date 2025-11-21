extends interactive

@export var open : bool = false
@onready var door_sprites: AnimatedSprite2D = $DoorSprites
@onready var collision_shape_close: CollisionShape2D = $StaticBody2D/CollisionShapeClose
@onready var collision_shape_open: CollisionShape2D = $StaticBody2D/CollisionShapeOpen
@onready var open_door: Sprite2D = $OpenDoor
const CLOSE_DOOR = preload("res://src/dialogues/es/close_door.dialogue")
@onready var interactive_area: CollisionShape2D = $InteractiveArea

func _ready():
	super._ready()
	icon = "key"
	if open:
		o_door()
	else:
		c_door()


func _process(_delta: float) -> void:
	if can_i_interact() and player != null: 
		if player.inventario.do_i_have_keys():
			player.inventario.remove_a_key()
			o_door()
		else:
			DialogueManager.show_dialogue_balloon(CLOSE_DOOR)	

func o_door():
	door_sprites.play("open")
	interactive_area.disabled = true
	collision_shape_close.disabled = true
	open_door.show()
	
func c_door():
	door_sprites.play("close")
	interactive_area.disabled = false
	collision_shape_close.disabled = false
	open_door.hide()
