extends Node
class_name Jump

#animacion
@export var jump_particles : PackedScene

#logica
const JUMP_VELOCITY = -300.0
var can_double_jump := true
var character: CharacterBody2D

func setup(character2D: CharacterBody2D):
	character = character2D
	
func update():
	if Input.is_action_just_pressed("ui_accept"):
		character.state = self
		if character.is_on_floor():
			AudioControler.play_sfx(preload("res://_assets/media/effects/jump-01.mp3"))
			spawn_jump_particles()
			character.velocity.y = JUMP_VELOCITY
			can_double_jump = true
		elif can_double_jump:
			AudioControler.play_sfx(preload("res://_assets/media/effects/jump-01.mp3"))
			spawn_jump_particles()
			character.velocity.y = JUMP_VELOCITY
			can_double_jump = false
	if(!character.is_on_floor() and !character.dash.is_dashing):
		character.state = self

func spawn_jump_particles():
	if jump_particles:
		var instance = jump_particles.instantiate()
		get_parent().add_child(instance) 
		instance.global_position = character.global_position + Vector2(0, 16)
		instance.emitting = true

func animation():
	if can_double_jump:
		character.play_anim("jump")
	else:
		character.play_anim("doble_jump")
