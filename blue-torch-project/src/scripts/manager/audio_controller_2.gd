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

func play_music(stream: AudioStream):
	if music_player.stream != stream:
		music_player.stream = stream
		music_player.play()

func play_sfx(stream: AudioStream, bus: String):
	var player := sfx_players[current_sfx_index]
	player.bus = bus
	current_sfx_index = (current_sfx_index + 1) % sfx_players.size()
	player.stream = stream
	player.play()
	
func play_sfx_alt(streams: Array[AudioStream], bus: String):
	var choice = streams[randi() % streams.size()];
	var player := sfx_players[current_sfx_index]
	player.bus = bus
	current_sfx_index = (current_sfx_index + 1) % sfx_players.size()
	player.stream = choice
	player.play()
