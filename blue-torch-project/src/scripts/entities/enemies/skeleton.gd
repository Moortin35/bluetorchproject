extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_field: Area2D = $DetectionField
@onready var hitbox: Area2D = $Hitbox


@export var walk_speed: float = -25.0
@export var chase_speed: float = -80.0
@export var damage: float = 1.0

@export var knockback_strength_hit : float = 4.0
@export var knockback_strength_attack : float = 4.0
@export var knockback_upward : float = -120.0
@export var hit_stun_duration : float = 0.18
@export var attack_stun_duration : float = 0.8



var current_speed: float = 0.0
var facing_right: bool = false
var player: Node2D = null
var knockback_timer : float = 0.0


func _ready() -> void:
	animated_sprite.play("walk")
	current_speed = walk_speed
	hitbox.body_entered.connect(_on_hitbox_body_entered)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if knockback_timer > 0.0:
		knockback_timer -= delta
		velocity.x = move_toward(velocity.x, 0, 1200 * delta)
	else:	
		if player == null :
			patrol_mode()
		else:
			chase_mode()
				
	move_and_slide()


func patrol_mode():
	if not ray_cast.is_colliding() and is_on_floor():
		flip()
		
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
			animated_sprite.play("walk")
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
	
func _on_detection_field_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
