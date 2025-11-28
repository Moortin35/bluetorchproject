extends interactive

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var broken = true
@export var _id = 0

const BROKEN_LEVER = preload("res://src/dialogues/es/broken_lever.dialogue")
var on = false


func _ready() -> void:
	super._ready()
	icon = "interact"
	if broken:
		sprite_2d.frame = 2
	else:
		sprite_2d.frame = 0
	
func _process(_delta: float) -> void:
	if can_i_interact():
		if(broken):
			if(player.player_inventory.do_i_have('lever')):
				broken = false
				player.player_inventory.remove_item('lever')
				sprite_2d.frame = 0
				DialogueManager.show_dialogue_balloon(BROKEN_LEVER,"fixed")
			else:
				DialogueManager.show_dialogue_balloon(BROKEN_LEVER,"broken")
		else:
			use_lever()
			
func use_lever():
	if on:
		on = false
		sprite_2d.frame = 0
		print("se apago")
	else:
		on = true
		sprite_2d.frame = 1
		print("se prendio")
	GlobalSignals.emit_signal("pulled_lever",_id,on)
		
		
	
