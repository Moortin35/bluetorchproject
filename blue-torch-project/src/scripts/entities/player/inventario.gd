extends Node2D

class_name inventory

@onready var keys : int = 0
@onready var items = []

	
func add_item(item):
	items.append(item)
	
func remove_item(item):
	items.erase(item)
	
func do_i_have(item):
	return items.has(item)
	
