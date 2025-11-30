extends StateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
var states=["charge","slam"]
@onready var timer_idle: Timer = $"../../Timer_idle"

var timer_start = false

func on_physics_process(delta: float) -> void:
	controlled_node.velocity.x = 0
	controlled_node.animated_sprite.play("idle")
	controlled_node.velocity.y += gravity * delta
	controlled_node.move_and_slide()
	if !timer_start:
		timer_idle.start()
		timer_start = true

func _on_timer_idle_timeout() -> void:
	state_machine.change_to(states.pick_random())
	timer_start = false
	
func end():
	timer_idle.stop()
