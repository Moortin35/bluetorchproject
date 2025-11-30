extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

@onready var direction = -1
@onready var charge_speed = 100

@onready var interactions: AnimatedSprite2D = $interactions
var fade_tween: Tween
var base_pos: Vector2

var health = 2

@onready var state_machine: StateMachine = $StateMachine

func play_icon(icon: String) -> void:
	if fade_tween and fade_tween.is_running():
		fade_tween.kill()

	interactions.show()
	interactions.play(icon)

	interactions.position = base_pos + Vector2(0, 10)
	interactions.modulate.a = 0.0

	fade_tween = get_tree().create_tween()
	fade_tween.set_trans(Tween.TRANS_SINE)
	fade_tween.set_ease(Tween.EASE_OUT)

	fade_tween.tween_property(interactions, "modulate:a", 1.0, 0.35)
	fade_tween.parallel().tween_property(interactions, "position", base_pos, 0.35)
	
func stop_icon() -> void:
	if fade_tween and fade_tween.is_running():
		fade_tween.kill()

	fade_tween = get_tree().create_tween()
	fade_tween.set_trans(Tween.TRANS_SINE)
	fade_tween.set_ease(Tween.EASE_IN)

	fade_tween.tween_property(interactions, "modulate:a", 0.0, 0.3)
	fade_tween.parallel().tween_property(interactions, "position", base_pos + Vector2(0, 10), 0.3)

	fade_tween.finished.connect(func():
		interactions.hide()
		interactions.position = base_pos
	)

func _on_fire_bowl_i_finished() -> void:
	health -= 1
	if health == 0:
		state_machine.change_to('death')

func _on_fire_bowl_2_i_finished() -> void:
	health -= 1
	if health == 0:
		state_machine.change_to('death')
