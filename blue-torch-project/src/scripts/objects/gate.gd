extends interactive

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var bowl_1 = false
var bowl_2 = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var end_test: CanvasLayer = $"../UI/EndTest"


func _ready():
	super._ready()
	icon = "interact"
	show_icon = false

func _process(_delta: float) -> void:
	if bowl_1 and  bowl_2:
		if can_i_interact() and player != null: 
			end_test.show()
		

func _on_fire_bowl_i_finished() -> void:
	bowl_1 = true
	if bowl_2:
		show_icon = true
		animated_sprite_2d.play("open")

func _on_fire_bowl_2_i_finished() -> void:
	bowl_2 = true
	if bowl_1:
		show_icon = true
		animated_sprite_2d.play("open")
