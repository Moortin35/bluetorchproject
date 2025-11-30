extends StateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_death = false

func on_physics_process(delta: float) -> void:
	if !is_death:
		controlled_node.animated_sprite.play("death")
		is_death = true
	controlled_node.velocity.x = 0
	controlled_node.velocity.y += gravity * delta
	controlled_node.move_and_slide()
