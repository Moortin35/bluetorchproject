extends Node2D

@onready var torch: AnimatedSprite2D = $torch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	torch.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
