extends CharacterBody2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_field: Area2D = $DetectionField


@export var walk_speed: float = -25.0
@export var chase_speed: float = -80.0
var current_speed: float = 0.0
var facing_right: bool = false
var player: Node2D = null

func _ready() -> void:
	animated_sprite.play("walk")
	current_speed = walk_speed

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
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



func _on_detection_field_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
	

func _on_detection_field_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
