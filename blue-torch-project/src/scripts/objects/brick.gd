extends RigidBody2D

@onready var danger_zone: Area2D = $DangerZone

func _ready():
	gravity_scale = 0.4
	danger_zone.is_lethal = false
	contact_monitor = true
	max_contacts_reported = 1

func _integrate_forces(state):
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider_object(i)
		if collider is TileMapLayer or collider is CharacterBody2D:
			if(collider is TileMapLayer):
				AudioControler.brick_destroy()
			queue_free()
			
