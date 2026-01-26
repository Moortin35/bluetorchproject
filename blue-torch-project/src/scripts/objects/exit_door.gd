extends interactive

@onready var next_level: CanvasLayer = $NextLevel
@export var level_to_pass: int
const END_LEVEL_MUSIC = preload("res://_assets/sounds/music/end_level_music.wav")
func _ready() -> void:
	super._ready()
	icon = "interact"

func _process(_delta: float) -> void:
	if can_i_interact():
		next_level.show()
		AudioController.play_music(END_LEVEL_MUSIC)
		player.can_control = false
