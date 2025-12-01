extends Node2D

@export var brick_scene: PackedScene		# Escena del ladrillo
@export var amount: int = 5		# Cantidad de ladrillos
@export var y_pos: float = -100			# Altura fija
@export var min_x: float = 0			# Límite izquierdo
@export var max_x: float = 1024			# Límite derecho
@export var separacion_min: float = 10		# Separación mínima en píxeles

func spawn_bricks(specific_amount = amount):
	Globals.camera.trigger_shake()
	var posiciones_x = []
	amount = specific_amount
	for i in range(amount):
		var x_valido = false
		var random_x = 0.0

		while not x_valido:
			random_x = randf_range(min_x, max_x)
			x_valido = true

			for x_prev in posiciones_x:
				if abs(random_x - x_prev) < separacion_min:
					x_valido = false
					break
		
		posiciones_x.append(random_x)

		var brick = brick_scene.instantiate()
		brick.position = Vector2(random_x, y_pos)
		get_parent().add_child(brick)


func _on_boss_spawn_bricks(amount) -> void:
	spawn_bricks(amount)
