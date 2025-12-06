extends CharacterBody2D

class_name Player

@onready var movement: Movement = $"state_set/Movement" as Movement
@onready var jump: Jump = $"state_set/Jump" as Jump
@onready var dash: Dash = $"state_set/Dash" as Dash
@onready var idle: Idle = $"state_set/Idle" as Idle
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var blue_torch: Node2D = $BlueTorch 
@onready var camera_2d: Camera2D = $Camera2D
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var player_inventory: inventory = $inventory
@onready var health_bar: Hud = $HealthBar


@export var health : float = 3.0

@onready var interactions: AnimatedSprite2D = $interactions
var fade_tween: Tween
var base_pos: Vector2

const KNOCKBACK_DURATION = 0.2 

var direction = 0
var last_direction = 1
var state = idle
var can_control := true
var is_dead := false
var invulnerable := false
var knockback_timer := 0.0

func _ready() -> void:
	movement.setup(self)
	jump.setup(self)
	dash.setup(self)
	idle.setup(self)
	blue_torch.setup(self)
	interactions.play()
	base_pos = interactions.position
	invulnerability_timer.timeout.connect(_on_invulnerability_timer_timeout)
	health_bar.create_hearts(health)
	
	
func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("interact"):
	#	.play_land()
	blue_torch.update(delta)
	if DialogueManager.is_dialoge_active:
		velocity += get_gravity() * delta
		velocity.x = 0
		if is_on_floor():
			play_anim("idle")
		move_and_slide()
		return
		
	if is_dead:
		velocity += get_gravity() * delta
		move_and_slide()
		return
	if not can_control:
		return
	if knockback_timer > 0:
		velocity.x = move_toward(velocity.x, 0, delta * 800)
		knockback_timer -= delta
	else:
		idle.update()
		direction = Input.get_axis("ui_left", "ui_right")
		if direction != 0:
			last_direction = direction
		if(!dash.is_dashing):
			movement.update(delta,velocity)
			velocity += get_gravity() * delta
			jump.update()
		dash.update(delta)
	move_and_slide()
	
	update_animation_player()

func take_damage(amount : float, source : Node2D = null) -> void:
	if !is_dead and !invulnerable:
		invulnerable = true
		
		health -= amount
		health_bar.lose_heart()
		animated_sprite_2d.stop()
		animated_sprite_2d.play("hit")
		print("player hit, health: ", health)
		if source:
			var knockback_dir = sign(global_position.x - source.global_position.x)
			velocity.x = 200 * knockback_dir
			velocity.y = -100
			knockback_timer = KNOCKBACK_DURATION
		else:
			print("Vacio")

		invulnerability_timer.start()

		if health <= 0:
			handle_danger()
		else:
			start_blink()

func start_blink() -> void:
	if not animated_sprite_2d:
		return

	var tween := create_tween()

	# Más lento → cada blink dura 0.2 s
	var blink_duration := 0.2	# antes 0.05

	# Recalcula loops para que dure lo mismo (convertido a entero)
	tween.set_loops(int(invulnerability_timer.wait_time / (blink_duration * 2)))

	# Más blanco → usa valores RGB mayores que 1
	tween.tween_property(animated_sprite_2d, "modulate",
		Color(7.0, 7.0, 7.0, 1.0), blink_duration)

	tween.tween_property(animated_sprite_2d, "modulate",
		Color(1, 1, 1, 1), blink_duration)

		
func play_anim(animated_name : String) -> void:
	if animated_sprite_2d.animation != animated_name:
		animated_sprite_2d.play(animated_name)

func update_animation_player() -> void:
	if direction != 0 and state != dash:
		animated_sprite_2d.flip_h = direction < 0
	state.animation()

func handle_danger() -> void:
	if !is_dead:
		is_dead = true
		AudioControler.play_sfx(preload("res://_assets/sounds/effects/Muerte PRUEBA ESTA SI AHRRE.wav"))
		AudioControler.stop_lvl1()
		can_control = false
		velocity.y = 0
		velocity.x = 0
		if not is_on_floor():
			animated_sprite_2d.play("hit")
			await get_tree().create_timer(0.5).timeout
		if is_on_floor():
			animated_sprite_2d.play("death")
		for i in health:
			health_bar.lose_heart()
		await get_tree().create_timer(2.5).timeout
		reset_player()

func _on_invulnerability_timer_timeout():
	invulnerable = false
	animated_sprite_2d.modulate.a = 1.0

func reset_player() -> void:
	var lv3 = LevelManager.loaded_level.level_id
	if lv3 == 3:
		LevelManager.load_level(3)
		pass
	AudioControler.play_lvl1()
	collision_shape_2d.disabled = false
	global_position = LevelManager.loaded_level.START_POS_LEVEL
	is_dead = false
	health = 3.0
	health_bar.create_hearts(health)
	can_control = true
	
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
	
