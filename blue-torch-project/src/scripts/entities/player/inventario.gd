extends Node2D

class_name inventory

@onready var keys : int = 0

func add_a_key():
	keys += 1
	
func remove_a_key():
	keys -= 1
	
func do_i_have_keys():
	return keys > 0
