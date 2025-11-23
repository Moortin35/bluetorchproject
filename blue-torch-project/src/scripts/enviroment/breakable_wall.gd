extends interactive

@export var broken : bool = false
@onready var wall_sprites: AnimatedSprite2D = $WallSprites
@onready var collision_shape_default: CollisionShape2D = $StaticBody2D/CollisionShapeDefault
@onready var collision_shape_collapsed: CollisionShape2D = $StaticBody2D/CollisionShapeCollapsed
@onready var debris_sprite: Sprite2D = $DebrisSprite
@onready var interactive_area: CollisionShape2D = $InteractiveArea

func _ready():
	super._ready()
	icon = "interact"
	if broken:
		broken_wall()
	else:
		unbroken_wall()


func _process(_delta: float) -> void:
	if can_i_interact() and player != null: 
			broken_wall()

			
func broken_wall():
	wall_sprites.play("collapsed")
	interactive_area.disabled = true
	collision_shape_default.disabled = true
	debris_sprite.show()
	
func unbroken_wall():
	wall_sprites.play("default")
	interactive_area.disabled = false
	collision_shape_default.disabled = false
	debris_sprite.hide()
