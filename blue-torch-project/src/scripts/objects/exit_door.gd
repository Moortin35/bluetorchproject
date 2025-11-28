extends interactive

@onready var next_level: CanvasLayer = $NextLevel
@export var level_to_pass: int

func _ready() -> void:
	super._ready()
	icon = "interact"

func _process(_delta: float) -> void:
	if can_i_interact():
		next_level.show()
		get_tree().paused = true
