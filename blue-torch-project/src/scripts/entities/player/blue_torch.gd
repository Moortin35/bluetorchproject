extends Node2D
class_name BlueTorch


#nodos de luz
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var point_light_2d_2: PointLight2D = $PointLight2D_2

#color de luz
var normal_color: Color = Color(0.8, 0.8, 1)
var dash_color: Color = Color(1, 3, 3)
var dead_color: Color = Color(1, 2, 10)
var target_color: Color = normal_color

#tamaño de luz
var normal_escala: float = 0.5
var scaled_dash_cooldown: float = 0.3
var dead_escala = 0
var target_escala: float = normal_escala


#particulas de la antorcha
@export var torch_particles : PackedScene
var particle_timer := 0.0
var particle_interval := 0.9



@onready var flicker_timer: Timer = $FlickerTimer

var base_energy: float = 0.5
var flicker_range: float = 0.1

var character

func setup(character2D: CharacterBody2D):
	character = character2D

func _ready() -> void:
	flicker_timer.timeout.connect(_on_flicker_timer_timeout)
	flicker_timer.wait_time = 0.3
	flicker_timer.start()

func _on_flicker_timer_timeout() -> void:
	var random_energy = randf_range(-flicker_range, flicker_range)
	point_light_2d.energy = clamp(base_energy + random_energy, 0.0, 1.0)

func update(delta:float):
	if(character.is_dead):
		cambiar_color_y_tamanio_luz_antorcha(dead_color,dead_escala)
		point_light_2d.color = point_light_2d.color.lerp(target_color, 3 * delta)
		point_light_2d.texture_scale = lerp(point_light_2d.texture_scale, target_escala, 3 * delta)
		point_light_2d_2.texture_scale = lerp(point_light_2d_2.texture_scale, target_escala, 3 * delta)
	else:
		point_light_2d.color = point_light_2d.color.lerp(target_color, 5 * delta)
		point_light_2d.texture_scale = lerp(point_light_2d.texture_scale, target_escala, 5 * delta)
		point_light_2d_2.texture_scale = lerp(point_light_2d_2.texture_scale, target_escala, 5 * delta)
	#tamaño y color de antorcha
		if(character.dash.can_dash):
			cambiar_color_y_tamanio_luz_antorcha(normal_color,normal_escala)
		else:
			cambiar_color_y_tamanio_luz_antorcha(dash_color ,scaled_dash_cooldown)
	


	#particulas antorcha
	spawn_torch_particles(delta)
	
func cambiar_radio(radio) -> void:
	point_light_2d.texture_scale = radio
	
func cambiar_color_y_tamanio_luz_antorcha(color : Color ,escala :float):
	target_color = color
	target_escala = escala
	
func spawn_torch_particles(delta):
	particle_timer -= delta
	if particle_timer <= 0.0:
		var instance = torch_particles.instantiate()
		get_parent().add_child(instance) 
		instance.global_position = global_position + Vector2(character.last_direction * 9, -3)
		instance.direction = Vector2(-character.direction, -1)
		instance.emitting = true 
		particle_timer = particle_interval
