extends Node2D

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var flicker_timer: Timer = $FlickerTimer

var base_energy: float = 0.5
var flicker_range: float = 0.1

func _ready() -> void:
	flicker_timer.timeout.connect(_on_flicker_timer_timeout)
	flicker_timer.wait_time = 0.3
	flicker_timer.start()

func _on_flicker_timer_timeout() -> void:
	var random_energy = randf_range(-flicker_range, flicker_range)
	point_light_2d.energy = clamp(base_energy + random_energy, 0.0, 1.0)
	

func cambiar_radio(radio) -> void:
	point_light_2d.texture_scale = radio
