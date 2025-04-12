extends Node2D

@export var civilian_count = 8
@export var goblin_type = 'goblin'

@export var riddle = "The quick brown fox jumps over the lazy dog"

@export var speed_difficulty = 0
#@export var speed_randomness = 0.5

func _ready():
	for civvies in civilian_count:
		var new_pip = Pip.new_pip("civilian")
		var random_direction = randi_range(0,359)
		var speed_fuzz = (randi_range(0,200)) + speed_difficulty
		var random_start = Vector2(randi_range(0, get_window().size.x), randi_range(0, get_window().size.y))
		print()
		new_pip.speed += speed_fuzz
		add_child(new_pip)
		new_pip.start(random_start, random_direction)
	var new_goblin = Pip.new_pip(goblin_type)
	add_child(new_goblin)
	pass
