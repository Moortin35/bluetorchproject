extends Node2D

@export var max_distance: float = 600.0
@export var fire_rate: float = 1.5              
@export var fireball_speed: float = 300.0
@export var fireball_scene: PackedScene
@export var fire_offset: float = 0.0           

var origin_position: Vector2

func _ready():
	origin_position = global_position
	_start_firing()

func _start_firing() -> void:
	# Espera el desfase antes del primer disparo
	await get_tree().create_timer(fire_offset).timeout

	# Disparo infinito con intervalo fijo
	while true:
		spawn_fireball()
		await get_tree().create_timer(fire_rate).timeout

func spawn_fireball() -> void:
	if fireball_scene == null:
		push_error("No se asignó fireball_scene.")
		return
	
	var fireball = fireball_scene.instantiate()
	get_tree().current_scene.add_child(fireball)
	
	fireball.global_position = global_position
	fireball.speed = fireball_speed
	fireball.max_distance = max_distance
	fireball.start_position = global_position
