extends Node2D

@export var mute: bool = false

func _ready():
	if not mute:
		play_music()
		
func play_music():
	if not mute:
		$Main_Theme.play()
		
func stop_music():
		$Main_Theme.stop()
		
func play_lvl1():
	$lvl_1_theme.play()

func stop_lvl1():
	$lvl_1_theme.stop()
