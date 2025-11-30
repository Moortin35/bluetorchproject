extends Node2D

@onready var light: PointLight2D = $light
@onready var particles: Node2D = $particles
@onready var ready_particles: CPUParticles2D = $ready_particles
@onready var light_2: PointLight2D = $light2

signal i_finished

var player_inside := false
var contador := 0
var limite := 60
var partes := 5
var incremento_luz := 0.01

var tiempo_acumulado := 0.0
var intervalo := 0.15

var siguiente_meta := 0
var indice_iteracion := 1    

func _ready():
	siguiente_meta = limite / partes

func _process(delta):
	if player_inside and contador < limite:
		light_2.show()
		tiempo_acumulado += delta
		if tiempo_acumulado >= intervalo:
			tiempo_acumulado = 0.0
			contador += 1
			light.texture_scale += incremento_luz
			if contador == siguiente_meta:
				particles.get_node(str(indice_iteracion)).emitting = true
				indice_iteracion += 1
				siguiente_meta += limite / partes
			if contador == limite:
				light_2.hide()
				i_finished.emit()
				ready_particles.emitting = true
				
				
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		light_2.hide()
		player_inside = false
