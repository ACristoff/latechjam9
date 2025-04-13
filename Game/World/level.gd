extends Node2D

@export var civilian_count = 12
@export var goblin_type = 'goblin'

@export var riddle = "The quick brown fox jumps over the lazy dog"

@export var riddles = []

@export var speed_difficulty = 0
#@export var speed_randomness = 0.5

@onready var eyes = $EyesOverlay

func start_game():
	for civvies in civilian_count:
		var new_pip = Pip.new_pip("civilian")
		var random_direction = randi_range(0,359)
		var speed_fuzz = (randi_range(0,200)) + speed_difficulty
		var random_start = Vector2(randi_range(0, get_window().size.x), randi_range(0, get_window().size.y))
		new_pip.speed += speed_fuzz
		add_child(new_pip)
		new_pip.start(random_start, random_direction)
		new_pip.sprite_parent.rotation = -random_direction
		new_pip.randomize_pip()

	var new_goblin = Pip.new_pip(goblin_type)
	#Debug
	
	var random_direction = randi_range(0,359)
	var random_start = Vector2(randi_range(0, get_window().size.x), randi_range(0, get_window().size.y))
	new_goblin.start(random_start, random_direction)
	add_child(new_goblin)
	new_goblin.sprite_parent.rotation = -random_direction
	new_goblin.sprite_parent.modulate = Color.GREEN	
	pass


func _ready():
	eyes.revelation()
	pass
