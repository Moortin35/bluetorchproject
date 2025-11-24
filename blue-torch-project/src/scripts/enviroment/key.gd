extends Area2D

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.player_inventory.add_a_key()
		AudioControler.play_cichin()
		get_parent().npc.queue_free()
		queue_free()
