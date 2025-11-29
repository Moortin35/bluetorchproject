extends Node2D

@onready var light: PointLight2D = $light
@onready var particles: Node2D = $particles
@onready var ready_particles: CPUParticles2D = $ready_particles

var player_inside := false
var contador := 0
var limite := 50                  # tu límite
var partes := 5                   # dividir en 5 secciones
var incremento_luz := 0.02

var tiempo_acumulado := 0.0
var intervalo := 0.1              # velocidad del contador

var siguiente_meta := 0           # se calculará en _ready()
var indice_iteracion := 1         # 1 = primera iteración, 2 = segunda, etc.

func _ready():
	siguiente_meta = limite / partes

func _process(delta):
	if player_inside and contador < limite:
		tiempo_acumulado += delta

		if tiempo_acumulado >= intervalo:
			tiempo_acumulado = 0.0
			contador += 1
			light.texture_scale += incremento_luz

			# Aquí sigue avisando por cada fracción, si quieres mantenerlo:
			if contador == siguiente_meta:
				print("Iteración ", indice_iteracion, " alcanzada")
				particles.get_child(indice_iteracion-1).emitting = true
				indice_iteracion += 1
				siguiente_meta += limite / partes

			# Mensaje final al llegar al límite
			if contador == limite:
				print("Meta alcanzada")
				ready_particles.emitting = true
				
				
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
