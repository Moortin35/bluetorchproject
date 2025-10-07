extends Node
class_name Movement

@export var acceleration = 1200.0
@export var freccion = 1200.0

@export var acceleracion_en_el_aire = 1200
@export var friccion_en_el_aire = 250

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

var player: CharacterBody2D

func setup(character2D: CharacterBody2D):
	player = character2D
	
func update(delta,velocity):
	#logica
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.velocity.y += clampf(player.velocity.y, -2,2)
		
		
	direction = Input.get_axis("ui_left", "ui_right")
	player.direction = direction
	if direction != 0:
		#player.velocity.x = direction * speed
		if player.is_on_floor():
			player.velocity.x = move_toward(player.velocity.x, player.direction * speed,acceleration * delta)
		else:
			player.velocity.x = move_toward(player.velocity.x, player.direction * speed,acceleracion_en_el_aire * delta)
	elif direction == 0:
		if player.is_on_floor():
			player.velocity.x = move_toward(player.velocity.x, 0.0 ,freccion * delta)
		else:
			player.velocity.x = move_toward(player.velocity.x,0 ,friccion_en_el_aire * delta)
	
	print(direction)
	
	# animacion
	if player.is_on_floor() and direction != 0 and !player.dash.is_dashing:
		player.state = self
	
	#sonido
	if player.is_on_floor() and abs(velocity.x) > 10 and player.animated_sprite_2d.animation == "walk":
		step_timer -= delta
		if step_timer <= 0.0:
			play_step_sound(velocity)
			step_timer = step_interval
	else:
		step_timer = 0.0
	
func stop_movement():
	player.velocity = Vector2.ZERO

func play_step_sound(velocity):
	if player.is_on_floor() and abs(velocity.x) > 10:
		var sound = step_sounds[randi() % step_sounds.size()]
		AudioControler.play_sfx(sound)
		
func animation():
	player.play_anim("walk")	
		
func is_facing_wall():
	return player.get_wall_normal().x == player.velocity.x
		
