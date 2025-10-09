extends Node
class_name Idle

var character: CharacterBody2D

func setup(character2D: CharacterBody2D):
	character = character2D
	
func update():
	if character.is_on_floor() and character.direction == 0 and !character.dash.is_dashing:
		character.state = self
	
func animation():
	character.play_anim("idle")
