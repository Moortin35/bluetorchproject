extends Node2D

@onready var light: PointLight2D = $light
@onready var particles: Node2D = $particles
@onready var ready_particles: CPUParticles2D = $ready_particles
@onready var light_2: PointLight2D = $light2

@onready var player_inside := false
@onready var contador := 0
@export var limite : float = 60.0
@onready var partes : float= 5.0
@onready var incremento_luz := 0.02


@onready var tiempo_acumulado := 0.0
@onready var intervalo := 0.15

@onready var siguiente_meta := 0.0
@onready var indice_iteracion := 1    

signal i_finished


func _ready():
	siguiente_meta =  int(limite / partes)

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
				siguiente_meta += float(limite) / partes
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
