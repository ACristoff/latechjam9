extends Node2D

@export var civilian_count = 5
@export var goblin_type = 'goblin'

func _ready():
	for civvies in civilian_count:
		var new_pip = Pip.new_pip("normal")
		add_child(new_pip)
	pass
