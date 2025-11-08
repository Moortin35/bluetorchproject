extends CharacterBody2D

class_name Player

@onready var movement: Movement = $"state_set/Movement" as Movement
@onready var jump: Jump = $"state_set/Jump" as Jump
@onready var dash: Dash = $"state_set/Dash" as Dash
@onready var idle: Idle = $"state_set/Idle" as Idle
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var blue_torch: Node2D = $BlueTorch 
@onready var camera_2d: Camera2D = $Camera2D
@onready var interactions: AnimatedSprite2D = $interactions

var fade_tween: Tween
var base_pos: Vector2

var direction = 0
var last_direction = 1
var state = idle

const START_POS_LEVEL_01 = Vector2(26.0, 640.0)
const START_POS_LEVEL_02 = Vector2(644.0, 364.0)

var can_control := true

var is_dead := false

func _ready() -> void:
	movement.setup(self)
	jump.setup(self)
	dash.setup(self)
	idle.setup(self)
	blue_torch.setup(self)
	interactions.play()
	base_pos = interactions.position
	
func _physics_process(delta: float) -> void:
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
	
	blue_torch.update(delta)
	update_animation_player()

func play_anim(animated_name : String) -> void:
	if animated_sprite_2d.animation != animated_name:
		animated_sprite_2d.play(animated_name)

func update_animation_player() -> void:
	if direction != 0 and state != dash:
		animated_sprite_2d.flip_h = direction < 0
	state.animation()

func handle_danger() -> void:
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
	await get_tree().create_timer(2.5).timeout
	reset_player()
	
func reset_player() -> void:
	AudioControler.play_lvl1()
	global_position = START_POS_LEVEL_01
	is_dead = false
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
	
