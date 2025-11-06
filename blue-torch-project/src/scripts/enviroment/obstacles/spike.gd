extends Node2D
class_name Spike

@onready var sprite: Sprite2D = $sprite
@export var nro_spike: int = 0

func _ready() -> void:
	var spike_width = 16
	var spike_height = 16
	var base_x = 48
	var base_y = 272
	
	if(!(nro_spike > 0 and nro_spike < 7)):
		nro_spike = randi_range(1, 6)
	var rect_x = base_x + (nro_spike * spike_width)
	var rect = Rect2(rect_x, base_y, spike_width, spike_height)
	sprite.region_rect = rect
