extends Node2D

@export var mute: bool = false
@onready var sfx_player: AudioStreamPlayer = $sfx_player


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
	
func play_sfx(stream: AudioStream):
	if not mute:
		sfx_player.stream = stream
		sfx_player.play()
