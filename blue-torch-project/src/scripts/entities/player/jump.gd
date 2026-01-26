extends Node
class_name Jump

#animacion
@export var jump_particles : PackedScene

const SFX_JUMP := preload("res://_assets/sounds/sfx/characters/player_jump_01.wav")
const SFX_LAND_1 := preload("res://_assets/sounds/sfx/characters/player_land_01.wav")
const SFX_LAND_2 := preload("res://_assets/sounds/sfx/characters/player_land_02.wav")

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
		AudioController.play_sfx_alt([SFX_LAND_1, SFX_LAND_2], "Reverb")
		can_double_jump = true
	if Input.is_action_just_pressed("saltar"):
		can_play_sound = true
		character.state = self
		if character.is_on_floor():
			AudioController.play_sfx(SFX_JUMP, "Reverb")
			spawn_jump_particles()
			character.velocity.y = JUMP_VELOCITY
		elif can_double_jump:
			AudioController.play_sfx(SFX_JUMP, "Reverb")
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
