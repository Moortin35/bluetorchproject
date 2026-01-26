extends Node
class_name Jump

#animacion
@export var jump_particles : PackedScene

const JUMP_SFX := preload("res://_assets/sounds/effects/jump-01.mp3")
const LAND_SFX := preload("res://_assets/sounds/effects/landing-01.mp3")
const LAND_2_SFX := preload("res://_assets/sounds/effects/landing-02.mp3")

#logica
const JUMP_VELOCITY = -300.0
var can_double_jump := true
var character: CharacterBody2D
var can_play_sound = false 

func setup(character2D: CharacterBody2D):
	character = character2D
	
func update():
	if can_play_sound and character.is_on_floor():
		can_play_sound = false
		AudioController.play_sfx_alt([LAND_SFX, LAND_2_SFX], "Reverb")
		can_double_jump = true
	if Input.is_action_just_pressed("saltar"):
		can_play_sound = true
		character.state = self
		if character.is_on_floor():
			AudioController.play_sfx(JUMP_SFX, "Reverb")
			spawn_jump_particles()
			character.velocity.y = JUMP_VELOCITY
		elif can_double_jump:
			AudioController.play_sfx(JUMP_SFX, "Reverb")
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
