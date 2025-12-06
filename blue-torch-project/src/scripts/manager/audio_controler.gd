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
		
func play_land():
	$land.play()
	$land2.play()

func play_cichin():
	$pick_key.play()
	
func play_open_dor():
	$open_door.play()
	
func play_aaa():
	$aaa.play()
	
func play_step_skeleton():
	var steps = [$skeleton_sound/step_sk1,$skeleton_sound/step_sk2]
	var step = steps[randi() % steps.size()]
	step.play()
	
func slam():
	$skeleton_sound/hit_1.play()
	$skeleton_sound/hit_2.play()

func lever():
	$environment_sound/lever_pull.play()

func pick_lever():
	$environment_sound/lever_pick.play()
	
