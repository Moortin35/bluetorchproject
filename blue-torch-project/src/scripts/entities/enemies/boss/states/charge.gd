extends StateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")

func on_physics_process(delta: float) -> void:
	controlled_node.animated_sprite.play("run")
	controlled_node.velocity.x = controlled_node.charge_speed * controlled_node.direction
	if controlled_node.is_on_wall():
		controlled_node.position.x = controlled_node.position.x - 25 * controlled_node.direction
		controlled_node.direction *= -1
		controlled_node.spawn_bricks.emit(3)
		controlled_node.animated_sprite.flip_h = controlled_node.direction < 0
		state_machine.change_to("idle")
	controlled_node.velocity.y += gravity * delta
	controlled_node.move_and_slide()
