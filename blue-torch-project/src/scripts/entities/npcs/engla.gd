extends interactive

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	super._ready()
	icon = "talk"
	animated_sprite_2d.play("idle")
	GlobalSignals.key_taken.connect(_on_key_taken)
	
			
func _on_key_taken():
	queue_free()  
		
