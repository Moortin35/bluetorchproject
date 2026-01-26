extends Area2D

const SFX_PICK_LEVER := preload("res://_assets/sounds/effects/pick_lever.mp3")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		AudioController.play_sfx(SFX_PICK_LEVER, "Reverb")
		body.player_inventory.add_item("lever")
		queue_free()
