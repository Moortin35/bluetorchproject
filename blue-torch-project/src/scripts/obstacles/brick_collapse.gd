extends Node2D

@export var brick_scene: PackedScene 
@export var y_pos: float = -100 
@export var min_x: float = 0 
@export var max_x: float = 1024 
@export var separacion_min: float = 10 


func _on_boss_spawn_bricks(amount) -> void:
	Globals.camera.trigger_shake()
	var positions_x = []
	for i in range(amount):
		var x_valid = false
		var random_x = 0.0

		while not x_valid:
			random_x = randf_range(min_x, max_x)
			x_valid = true

			for x_prev in positions_x:
				if abs(random_x - x_prev) < separacion_min:
					x_valid = false
					break
		
		positions_x.append(random_x)

		var brick = brick_scene.instantiate()
		brick.position = Vector2(random_x, y_pos)
		get_parent().add_child(brick)
