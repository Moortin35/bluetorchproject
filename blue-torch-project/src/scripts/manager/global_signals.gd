extends Node

signal key_taken()
signal pulled_lever(id,on)

func a():
	key_taken.emit()
	pulled_lever.emit()
