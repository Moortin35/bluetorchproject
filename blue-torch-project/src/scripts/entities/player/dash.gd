extends Node
class_name Dash

var character: CharacterBody2D
const DASH_SPEED = 200
const DASH_DURATION = 0.3
var dash_timer := 0.0
var can_dash := true
var is_dashing = false
@onready var dash_cooldown: Timer = $"../../dashCooldown"
@export var dash_particles : PackedScene

const SFX_DASH := preload("res://_assets/sounds/sfx/characters/player_dash_01.wav")

func _ready() -> void:
	dash_cooldown.timeout.connect(on_timer_timeout)

func setup(character2D: CharacterBody2D):
	character = character2D

func update(delta):
	if Input.is_action_just_pressed("dash") and not is_dashing and can_dash:
		start_dash()
		character.state = self
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			
func start_dash() -> void:
	spawn_dash_particles()
	AudioController.play_sfx(SFX_DASH, "Reverb")
	is_dashing = true
	can_dash = false
	character.velocity.x = character.last_direction * DASH_SPEED
	character.velocity.y = 0
	dash_timer = DASH_DURATION
	dash_cooldown.start()
		
func on_timer_timeout():
	can_dash = true
	
func spawn_dash_particles():
	if dash_particles:
		var instance = dash_particles.instantiate()
		get_parent().add_child(instance) 
		instance.global_position = character.global_position + Vector2(0, 0)
		instance.gravity =  Vector2(character.last_direction * instance.gravity.x , 0)
		instance.emitting = true
		
func animation():
	character.play_anim("dash")
