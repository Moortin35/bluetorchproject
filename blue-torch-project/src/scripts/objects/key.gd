extends Area2D

const SFX_PICK_KEY := preload("res://_assets/sounds/effects/pick_key.mp3")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.player_inventory.add_item("key")
		AudioController.play_sfx(SFX_PICK_KEY, "Reverb")
		GlobalSignals.emit_signal("key_taken")
		queue_free()
