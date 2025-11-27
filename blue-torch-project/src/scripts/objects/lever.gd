extends interactive

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var broken = true
@export var _id = 0

const PALANCA_ROTA = preload("res://src/dialogues/es/palanca_rota.dialogue")
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
				DialogueManager.show_dialogue_balloon(PALANCA_ROTA,"arreglar")
			else:
				DialogueManager.show_dialogue_balloon(PALANCA_ROTA,"rota")
		else:
			mover_palanca()
			
func mover_palanca():
	if on:
		on = false
		sprite_2d.frame = 0
		print("se apago")
	else:
		on = true
		sprite_2d.frame = 1
		print("se prendio")
	GlobalSignals.emit_signal("the_lever_moved",_id,on)
		
		
	
