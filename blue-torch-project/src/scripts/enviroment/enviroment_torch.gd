extends Node2D

@onready var light: PointLight2D = $Light
@onready var animation_torch: AnimatedSprite2D = $AnimationTorch
@onready var flicker_timer: Timer = $FlickerTimer
@export var radius = 0.3

var base_energy: float = 0.9
var flicker_range: float = 0.1

func _ready() -> void:
	light.texture_scale = radius
	flicker_timer.timeout.connect(_on_flicker_timer_timeout)
	flicker_timer.wait_time = 0.3
	flicker_timer.start()

	animation_torch.play()

func _on_flicker_timer_timeout() -> void:
	var random_energy = randf_range(-flicker_range, flicker_range)
	light.energy = clamp(base_energy + random_energy, 0.0, 1.0)
