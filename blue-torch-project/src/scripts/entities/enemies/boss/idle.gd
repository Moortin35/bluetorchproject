extends StateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")

func on_physics_process(delta: float) -> void:
	controlled_node.animated_sprite.play("idle")
	controlled_node.velocity.y += gravity * delta
	controlled_node.move_and_slide()
