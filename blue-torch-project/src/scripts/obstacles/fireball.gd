extends Node2D

@export var speed: float = 300.0
@export var max_distance: float = 600.0
var start_position: Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var explosion: CPUParticles2D = $explosion
@onready var light: PointLight2D = $Light


func _ready() -> void:
	start_position = global_position


func _process(delta: float) -> void:
	position.x += speed * delta

	if abs(global_position.x - start_position.x) >= max_distance:
		_explode()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(1.0, self)
		_explode()


func _explode() -> void:
	_hide_fire_ball()

	explosion.emitting = true
	speed = 0

	var tween := create_tween()
	tween.tween_property(light, "energy", 0.0, 0.2)

	await tween.finished
	queue_free()
	
func _hide_fire_ball():
	sprite_2d.hide()
	collision_shape_2d.set_deferred("disabled", true)
	cpu_particles_2d.hide()
	#light.hide()
