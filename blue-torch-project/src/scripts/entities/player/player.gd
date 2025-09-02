extends CharacterBody2D

class_name Player

@onready var dash_cooldown: Timer = $dashCooldown
@onready var blue_torch: Node2D = $blue_torch
@onready var point_light_2d: PointLight2D = $blue_torch/PointLight2D
@onready var point_light_2d_2: PointLight2D = $blue_torch/PointLight2D_2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const START_POS_LEVEL_00 = Vector2(26.0, 640.0)

const SPEED = 100

const JUMP_VELOCITY = -300.0
var can_double_jump := true
var direction = 0

const DASH_SPEED = 200
const DASH_DURATION = 0.3
var is_dashing := false
var dash_timer := 0.0
var can_dash := true
var direction_dash = 1

var can_control := true

var is_dead := false

var normal_color: Color = Color(0.8, 0.8, 1)
var dash_color: Color = Color(1, 3, 3)
var target_color: Color = normal_color

var normal_escala: float = 0.5
var scaled_dash_cooldown: float = 0.3
var target_escala: float = normal_escala

var step_sounds: Array[AudioStream] = [
	preload("res://_assets/media/effects/walk-01.mp3"),
	preload("res://_assets/media/effects/walk-02.mp3")
]

var step_interval := 0.5
var step_timer := 0.0

#Se llama una vez cuando el nodo y sus hijos están en el árbol de la escena, usado para inicialización.
func _ready() -> void:
	dash_cooldown.timeout.connect(on_timer_timeout)
	

#Se ejecuta durante la física del bucle principal. delta es el tiempo entre pasos de física (en segundos).
func _physics_process(delta: float) -> void:
	
	if is_dead:
		velocity += get_gravity() * delta
		move_and_slide()
		return
		
	if not can_control:
		return

	# agregamos gravedad
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta
	
	#cuando se presiona la tecla sifht
	handle_dash(delta)
	#cuando se presiona la tecla espacio
	handle_jump()
	#cuando se presionan las teclas flecha izquiera, flecha derecha
	handle_movement()
	update_animation_player(is_on_floor())
	update_animation_torch(delta)
	
	if is_on_floor() and abs(velocity.x) > 10 and animated_sprite_2d.animation == "walk":
		step_timer -= delta
		if step_timer <= 0.0:
			play_step_sound()
			step_timer = step_interval
	else:
		step_timer = 0.0


func handle_dash(delta:float):
	if direction != 0:
		direction_dash = direction
	if Input.is_action_just_pressed("dash") and not is_dashing and can_dash:
		start_dash()
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			
func handle_jump():
	
	if Input.is_action_just_pressed("ui_accept") and !is_dashing :
		if is_on_floor():
			AudioControler.play_sfx(preload("res://_assets/media/effects/jump-01.mp3"))
			velocity.y = JUMP_VELOCITY
			can_double_jump = true
		elif can_double_jump:
			AudioControler.play_sfx(preload("res://_assets/media/effects/jump-01.mp3"))
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			
func handle_movement():
	direction = Input.get_axis("ui_left", "ui_right")
	if not is_dashing:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func start_dash() -> void:
		AudioControler.play_sfx(preload("res://_assets/media/effects/dash-01.mp3"))
		is_dashing = true
		can_dash = false
		velocity.x = direction_dash * DASH_SPEED
		velocity.y = 0
		cambiar_color_y_tamanio_luz_antorcha(dash_color ,scaled_dash_cooldown)
		dash_timer = DASH_DURATION
		dash_cooldown.start()

func on_timer_timeout():
	can_dash = true
	cambiar_color_y_tamanio_luz_antorcha(normal_color,normal_escala)

func cambiar_color_y_tamanio_luz_antorcha(color : Color ,escala :float):
	target_color = color
	target_escala = escala
		
func update_animation_player(on_floor : bool) -> void:
	#para que se flipeen las animaciones, quitando la de dash
	if direction != 0 and !is_dashing:
		animated_sprite_2d.flip_h = direction < 0
	if is_dashing:
		play_anim("dash")
	elif not on_floor:
		if can_double_jump:
			play_anim("jump")
		else:
			play_anim("doble_jump")
	elif abs(velocity.x) > 10:
		play_anim("walk")
	else:
		play_anim("idle")

func play_anim(animated_name : String) -> void:
	if animated_sprite_2d.animation != animated_name:
		animated_sprite_2d.play(animated_name)

func update_animation_torch(delta:float):
	point_light_2d.color = point_light_2d.color.lerp(target_color, 5 * delta)
	point_light_2d.texture_scale = lerp(point_light_2d.texture_scale, target_escala, 5 * delta)
	point_light_2d_2.texture_scale = lerp(point_light_2d_2.texture_scale, target_escala, 5 * delta)
			
func handle_danger() -> void:
	is_dead = true
	can_control = false
	velocity.y = 0
	velocity.x = 0
	if not is_on_floor():
		animated_sprite_2d.play("hit")
		await get_tree().create_timer(0.5).timeout
	if is_on_floor():
		animated_sprite_2d.play("death")
	await get_tree().create_timer(1.5).timeout
	reset_player()
	
func reset_player() -> void:
	global_position = START_POS_LEVEL_00
	is_dead = false
	can_control = true
	
func play_step_sound():
	if is_on_floor() and abs(velocity.x) > 10:
		var sound = step_sounds[randi() % step_sounds.size()]
		AudioControler.play_sfx(sound)
		
