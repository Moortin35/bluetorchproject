extends Node2D

@export var mute: bool = false

func _ready():
	if not mute:
		play_music()
		
func play_music():
	if not mute:
		$Music.play()
		
func stop_music():
		$Music.stop()
