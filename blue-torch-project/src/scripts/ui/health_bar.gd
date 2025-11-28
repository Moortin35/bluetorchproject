extends CanvasLayer

class_name Hud

@onready var hearts: HBoxContainer = $MarginContainer/Hearts

var texture_heart = preload("res://_assets/sprites/icons/heart_icon.png")
var array_hearts: Array[TextureRect] = []

func create_hearts(hearts_amount: float):
	for i in hearts_amount:
		var texture_rect = TextureRect.new()
		texture_rect.custom_minimum_size = Vector2(48,48)
		texture_rect.texture = texture_heart
		texture_rect.texture_filter = TextureRect.TEXTURE_FILTER_NEAREST
		hearts.add_child(texture_rect)
		array_hearts.append(texture_rect)
		
func lose_heart():
	#eliminamos un elemento del arreglo de texturas vidas
	var substracted_heart = array_hearts.pop_back()
	#liberamos el contenido
	substracted_heart.queue_free()
