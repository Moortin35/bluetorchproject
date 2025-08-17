extends CharacterBody2D

class_name Player

@onready var dash_cooldown: Timer = $dashCooldown
@onready var point_light_2d: PointLight2D = $antorcha/PointLight2D
@onready var antorcha: Node2D = $antorcha


const SPEED = 100
const JUMP_VELOCITY = -300.0
#representa la fuerza del salto, es en negativo porque en Godot,
										# el "eje Y" hacia arriba es negativo
const DASH_SPEED = 200
const DASH_DURATION = 0.3


var is_dashing := false
var dash_timer := 0.0
var can_double_jump := true
var can_dash := true

var normal_color: Color = Color(1, 1, 1)
var dash_color: Color = Color(1, 3, 3)
var target_color: Color = normal_color


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#al iniciar realiza la animación de idle
func _ready() -> void:
	play_anim("idle")
	dash_cooldown.timeout.connect(on_timer_timeout)

func on_timer_timeout():
	can_dash = true
	target_color = normal_color
		
#verifica en todo momento, trabaja la logica de fisica por frame
func _physics_process(delta: float) -> void:
	var on_floor := is_on_floor()
	#en este caso obtiene la direccion de entrada (vale -1 izq, 1 der, 0 ninguna)
	var direction := Input.get_axis("ui_left", "ui_right")

	if Input.is_action_just_pressed("dash") and not is_dashing and can_dash:
		start_dash(direction)
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false

	# Add the gravity.
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

	#cuando se presiona la tecla espacio
	if Input.is_action_just_pressed("ui_accept") and !is_dashing :
		if on_floor:
			velocity.y = JUMP_VELOCITY
			can_double_jump = true
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false

	#desplazamiento horizontal mientras no se esta dasheando
	if not is_dashing:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#para que se flipeen las animaciones, quitando la de dash
	if direction != 0 and !is_dashing:
		animated_sprite_2d.flip_h = direction < 0
			

	update_animation(on_floor, direction)
	move_and_slide()
	point_light_2d.color = point_light_2d.color.lerp(target_color, 5 * delta)

	
func start_dash(direction : float) -> void:
		if direction == 0:
			return
		is_dashing = true
		dash_timer = DASH_DURATION
		velocity.x = direction * DASH_SPEED
		velocity.y = 0
		target_color = dash_color
		can_dash = false
		dash_cooldown.start()
		
func play_anim(name : String) -> void:
	if animated_sprite_2d.animation != name:
		animated_sprite_2d.play(name)

func update_animation(on_floor : bool, direction : float) -> void:
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
