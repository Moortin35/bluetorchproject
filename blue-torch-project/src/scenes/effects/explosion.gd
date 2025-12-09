extends CPUParticles2D

@onready var point_light_2d: PointLight2D = $PointLight2D

@export var flash_energy: float = 2.0      # intensidad de la luz al inicio
@export var flash_time: float = 0.12       # duración del destello

func explode():
	# Activar partículas
	emitting = true

	# Hacer el destello de luz
	_flash_light()

	# Esperar a que la explosión termine
	await get_tree().create_timer(1.0).timeout
	
	queue_free()


func _flash_light():
	point_light_2d.visible = true
	point_light_2d.energy = flash_energy

	var t := 0.0

	while t < flash_time:
		t += get_process_delta_time()
		point_light_2d.energy = lerp(flash_energy, 0.0, t / flash_time)
		await get_tree().process_frame

	point_light_2d.visible = false
