extends Node
class_name Movement

#logica
var speed: float = 100.0
var max_speed: float = 100.0
var direction: float = 0

#sonido
var step_interval := 0.5
var step_timer := 0.0
var step_sounds: Array[AudioStream] = [
	preload("res://_assets/media/effects/walk-01.mp3"),
	preload("res://_assets/media/effects/walk-02.mp3")
]

var character: CharacterBody2D

func setup(character2D: CharacterBody2D):
	character = character2D
	
func update(delta,velocity):
	#logica
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		character.velocity.x = direction * speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, speed)
	
	# animacion
	if character.is_on_floor() and direction != 0 and !character.dash.is_dashing:
		character.state = self
	
	#sonido
	if character.is_on_floor() and abs(velocity.x) > 10 and character.animated_sprite_2d.animation == "walk":
		step_timer -= delta
		if step_timer <= 0.0:
			play_step_sound(velocity)
			step_timer = step_interval
	else:
		step_timer = 0.0
	
func stop_movement():
	character.velocity = Vector2.ZERO

func play_step_sound(velocity):
	if character.is_on_floor() and abs(velocity.x) > 10:
		var sound = step_sounds[randi() % step_sounds.size()]
		AudioControler.play_sfx(sound)
		
func animation():
	character.play_anim("walk")
