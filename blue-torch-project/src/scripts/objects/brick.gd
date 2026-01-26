extends RigidBody2D

@onready var danger_zone: Area2D = $DangerZone
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var danger_zone_colision: CollisionShape2D = $DangerZone/dangerZoneColision

@onready var particles_brick: Node2D = $particles_brick

const SFX_BRICKS := [
	preload("res://_assets/sounds/effects/efectos entorno/Piedras 1.wav"),
	preload("res://_assets/sounds/effects/efectos entorno/Piedras 2.wav"),
	preload("res://_assets/sounds/effects/efectos entorno/Piedras 3.wav"),
	preload("res://_assets/sounds/effects/efectos entorno/Piedras 3-1.wav")
]

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
				AudioController.play_sfx_alt(SFX_BRICKS)
			_hide_brick()
			emit_all_particles()
			await get_tree().create_timer(1).timeout
			queue_free()

func _hide_brick():
	gravity_scale = 0
	sprite_2d.hide()
	danger_zone_colision.set_deferred("disabled", true)
	collision_shape_2d.set_deferred("disabled", true)
	
func emit_all_particles():
	for child in particles_brick.get_children():
		child.emitting = true
	
