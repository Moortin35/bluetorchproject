extends StateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")

const SFX_SKELETON_STEP: Array[AudioStream] = [
	preload("res://_assets/sounds/sfx/characters/boss_skeleton_step_01.wav"),
	preload("res://_assets/sounds/sfx/characters/boss_skeleton_step_02.wav")
]

const SFX_SKELETON_SLAM: Array[AudioStream] = [
	preload("res://_assets/sounds/sfx/characters/boss_skeleton_hit_01.wav"),
	preload("res://_assets/sounds/sfx/characters/boss_skeleton_hit_02.wav")
]

var step_interval := 0.45
var step_timer := 0.0

func on_physics_process(delta: float) -> void:
	controlled_node.animated_sprite.play("run")
	if controlled_node.is_on_floor():
		step_timer -= delta
		if step_timer <= 0.0:
			AudioController.play_sfx_alt(SFX_SKELETON_STEP)
			step_timer = step_interval
	else:
		step_timer = 0.0
	controlled_node.velocity.x = controlled_node.charge_speed * controlled_node.direction
	if controlled_node.is_on_wall():
		controlled_node.position.x = controlled_node.position.x - 25 * controlled_node.direction
		controlled_node.direction *= -1
		controlled_node.emit_spawn_bricks(3)
		controlled_node.animated_sprite.flip_h = controlled_node.direction < 0
		AudioController.play_sfx_alt(SFX_SKELETON_SLAM)
		state_machine.change_to("idle")
	controlled_node.velocity.y += gravity * delta
	controlled_node.move_and_slide()
	
