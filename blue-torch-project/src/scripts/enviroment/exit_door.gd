extends interactive

@onready var next_level: CanvasLayer = $"../NextLevel"

func _ready() -> void:
	super._ready()
	icon = "interact"

func _process(_delta: float) -> void:
	if can_i_interact():
		next_level.mostrar_menu()
