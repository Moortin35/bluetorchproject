extends Node

@export var sfx_player_count := 8

var sfx_players: Array[AudioStreamPlayer] = []
var current_sfx_index := 0

var music_bus_index = AudioServer.get_bus_index("Music")
var dialogue_bus_index = AudioServer.get_bus_index("Dialogue")
var sfx_bus_index = AudioServer.get_bus_index("SFX")
var ui_bus_index = AudioServer.get_bus_index("UI")

var music_bus_volume: float = 0.0
var sfx_bus_volume: float = 0.0
var dialogue_bus_volume: float = 0.0
var ui_bus_volume: float = 0.0

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

func set_ui_volume(db: float):
	AudioServer.set_bus_volume_db(ui_bus_index, (db))
	ui_bus_volume = db

func set_music_volume(db: float):
	AudioServer.set_bus_volume_db(music_bus_index, (db))
	music_bus_volume = db
	
func set_sfx_volume(db: float):
	AudioServer.set_bus_volume_db(sfx_bus_index, (db))
	sfx_bus_volume = db
	
func set_dialogue_volume(db: float):
	AudioServer.set_bus_volume_db(dialogue_bus_index, (db))
	dialogue_bus_volume = db
