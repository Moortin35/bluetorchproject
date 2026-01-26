extends Node

@export var sfx_player_count := 8

var sfx_players: Array[AudioStreamPlayer] = []
var current_sfx_index := 0

@onready var music_player := AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	music_player.bus = "Music"
	for i in sfx_player_count:
		var p := AudioStreamPlayer.new()
		p.bus = "SFX"
		add_child(p)
		sfx_players.append(p)

func play_music(stream: AudioStream, force_restart: bool = false):
	if music_player.stream != stream:
		music_player.stream = stream
		music_player.play()
		return
	if force_restart:
		music_player.play()
		

func stop_music():
	music_player.stop()

func _get_player(bus: String) -> AudioStreamPlayer:
	var player := sfx_players[current_sfx_index]
	current_sfx_index = (current_sfx_index + 1) % sfx_players.size()
	player.bus = bus
	return player

func play_sfx(stream: AudioStream, bus := "SFX"):
	var player := _get_player(bus)
	player.stream = stream
	player.play()

func play_sfx_alt(streams: Array[AudioStream], bus := "SFX"):
	if streams.is_empty():
		return
	var choice: AudioStream = streams.pick_random()
	play_sfx(choice, bus)
