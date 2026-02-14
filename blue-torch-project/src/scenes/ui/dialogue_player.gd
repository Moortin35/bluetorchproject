extends AudioStreamPlayer

var dialogue_sounds: Dictionary = {
	# Por defecto
	"default": [preload("res://_assets/sounds/sfx/dialogue/dialogue_default_01.wav")],
	# Gerda
	"gerda": [
		preload("res://_assets/sounds/sfx/dialogue/gerda/dialogue_gerda_01.wav"),
		preload("res://_assets/sounds/sfx/dialogue/gerda/dialogue_gerda_02.wav"),
		preload("res://_assets/sounds/sfx/dialogue/gerda/dialogue_gerda_03.wav"),
		preload("res://_assets/sounds/sfx/dialogue/gerda/dialogue_gerda_04.wav")
	],
	# Odd Man
	"odd_man": [preload("res://_assets/sounds/sfx/dialogue/dialogue_odd_man.wav")],
	# Engla
	"engla": [
		preload("res://_assets/sounds/sfx/dialogue/engla/dialogue_engla_01.wav"),
		preload("res://_assets/sounds/sfx/dialogue/engla/dialogue_engla_02.wav"),
		preload("res://_assets/sounds/sfx/dialogue/engla/dialogue_engla_03.wav")
	]
}

var streams: Dictionary = {
	"default": AudioStreamRandomizer.new(),
	"gerda": AudioStreamRandomizer.new(),
	"odd_man": AudioStreamRandomizer.new(),
	"engla": AudioStreamRandomizer.new(),
}

var synonyms: Dictionary[String, Array] = {
	"gerda": ["gerda", "maiden"],
	"engla": ["dama_desconocida", "engla"],
	"odd_man": ["odd_man"],
}

var pitch_variations: Dictionary = {
	"default": 1.1,
	"gerda": 1.1,
	"engla": 1.1,
	"odd_man": 1.1
}

func _ready():
	_init_streams();
		
func _init_streams():
	for character in dialogue_sounds.keys():
		var sounds = dialogue_sounds.get(character)
		stream = streams.get(character)
		stream.set_random_pitch(pitch_variations.get(character))
		for sound in sounds.size():
			stream.add_stream(sound, sounds[sound], 1)
			
func _get_synonym(query: String) -> String:
	query = query.strip_edges()
	for character in synonyms.keys():
		var list: Array = synonyms[character]
		if list.has(query):
			return character
	return "default"
	

func set_character(character: String):
	var synonym = _get_synonym(character)
	stream = streams.get(synonym)


	
