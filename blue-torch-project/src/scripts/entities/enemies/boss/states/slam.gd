extends StateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer_slam: Timer = $"../../Timer_slam"
var timer_start = false

func on_physics_process(delta: float) -> void:
	controlled_node.velocity.x = 0
	controlled_node.animated_sprite.play("attack_2")
	controlled_node.velocity.y += gravity * delta
	controlled_node.move_and_slide()
	if !timer_start:
		timer_slam.start()
		timer_start = true
	

func _on_timer_slam_timeout() -> void:
	state_machine.change_to("idle")
	timer_start = false

func end():
	timer_slam.stop()
