extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_field: Area2D = $DetectionField
@onready var hitbox: Area2D = $Hitbox


@export var walk_speed: float = -25.0
@export var chase_speed: float = -80.0
@export var damage: float = 1.0

#En caso de que la maiden posea un ataque y pueda dañar al esqueleto
#@export var knockback_strength_hit : float = 4.0
@export var knockback_strength_attack : float = 100.0
@export var knockback_upward : float = -120.0
#@export var hit_stun_duration : float = 0.18
@export var attack_stun_duration : float = 0.8

var current_speed: float = 0.0
var facing_right: bool = false
var can_patrol: bool = true
var player: Node2D = null

var knockback_timer : float = 0.0

@onready var interactions: AnimatedSprite2D = $interactions
var fade_tween: Tween
var base_pos: Vector2

var confused = false

func _ready() -> void:
	current_speed = walk_speed
	interactions.play()
	base_pos = interactions.position
#	hitbox.body_entered.connect(_on_hitbox_body_entered)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if player == null:
		can_patrol = true
	else:
		can_patrol = !player.is_dead
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if knockback_timer > 0.0:
		knockback_timer -= delta
		velocity.x = move_toward(velocity.x, 0, 1200 * delta)
	else:	
		if can_patrol and !confused:
			if player == null:
				animated_sprite.play("walk")
				patrol_mode()
			else:
				chase_mode()
		else:
			velocity.x = 0
			animated_sprite.play("idle")

				
	move_and_slide()


func patrol_mode():
	
	if not ray_cast.is_colliding() and is_on_floor():
		flip()
		interactions.scale.x *= -1
	velocity.x = walk_speed	


func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		walk_speed = abs(walk_speed)
	else:
		walk_speed = abs(walk_speed) * -1
		
		
func chase_mode():	
	if is_on_floor() and ray_cast.is_colliding():
		var direction = sign(player.global_position.x - global_position.x)
		
		if(direction > 0  and facing_right) or (direction < 0 and not facing_right):
			animated_sprite.play("run")
			velocity.x = abs(chase_speed) * (1 if facing_right else -1)
		else:
			animated_sprite.play("idle")
			velocity.x = 0
	else:
		animated_sprite.play("idle")
		velocity.x = 0


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animated_sprite.play("attack_1")
		body.take_damage(damage, self)
		print("Enemy hit player! Damage: ", damage)
		var dir = sign(global_position.x - body.global_position.x)
		velocity.x = knockback_strength_attack * dir
		velocity.y  = knockback_upward * 0.5
		knockback_timer = attack_stun_duration


func _on_detection_field_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		confused = false
		stop_icon()
	
func _on_detection_field_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
	confused = true
	play_icon("lose track")
	await get_tree().create_timer(1).timeout
	stop_icon()
	confused = false
	
		
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
