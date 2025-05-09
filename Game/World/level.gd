extends Node2D

@export var civilian_count = 5
@export var goblin_type = 'goblin'

@export var riddle = "The quick brown fox jumps over the lazy dog"

@export var riddles = [
	"This goblin forgot deoderant",
	"This goblin hates sunlight",
	"This goblin is feeling frisky",
	"This goblin is the cat's meow",
	"This goblin is a good listener",
	"This goblin might rawr X3 at you..."
]

@export var speed_difficulty = 0
#@export var speed_randomness = 0.5

@onready var eyes: Eyes = $EyesOverlay
var random_riddle = randi_range(0,5)
var game_active = false
var all_pips = []


func start_game():
	print('starting game haha')
	for civvies in civilian_count:
		var new_pip = Pip.new_pip("civilian")
		var random_direction = randi_range(0,359)
		var speed_fuzz = (randi_range(0,200)) + speed_difficulty
		var random_start = Vector2(randi_range(0, get_window().size.x), randi_range(0, get_window().size.y))
		new_pip.speed += speed_fuzz
		add_child(new_pip)
		new_pip.start(random_start, random_direction)
		new_pip.sprite_parent.rotation = -random_direction
		new_pip.collision.rotation = -random_direction
		new_pip.randomize_pip()
		all_pips.append(new_pip)

	var new_goblin = Pip.new_pip(goblin_type)
	#Debug
	var random_direction = randi_range(0,359)
	var random_start = Vector2(randi_range(0, get_window().size.x), randi_range(0, get_window().size.y))
	new_goblin.start(random_start, random_direction)
	add_child(new_goblin)
	new_goblin.sprite_parent.rotation = -random_direction
	new_goblin.collision.rotation = -random_direction
	#new_goblin.sprite_parent.modulate = Color.GREEN
	new_goblin.riddled(random_riddle)
	print(random_riddle, riddles[random_riddle])
	all_pips.append(new_goblin)
	await get_tree().create_timer(8).timeout
	game_active = true


func _ready():
	eyes.thought_bubble.debug_phrase = riddles[random_riddle]
	eyes.revelation()
	SignalBus.add_score.connect(wipe_board.bind())
	SignalBus.next_level.connect(kill_myself.bind() )
	start_game()

func kill_myself():
	SignalBus.new_level.emit()
	queue_free()

func wipe_board():
	random_riddle = randi_range(0,5)
	for pip: Pip in all_pips:
		pip.queue_free()
		speed_difficulty += 25
		civilian_count += 2


func _process(delta):
	if Input.is_action_just_pressed("interact") && game_active == true:
		game_active = false
		for pip: Pip in all_pips:
			eyes.tracking = false
			pip.stop()
			$EndTimer.start()
		check_for_goblin(eyes.get_colliders())

func check_for_goblin(arr):
	if arr.size() > 0:
		for pip: Pip in arr:
			print(pip.pipType)
			if pip.pipType == "goblin":
				eyes.have_mode = true
	print(eyes.have_mode)

func _on_eyes_overlay_eyes_open():
	#start_game()
	pass

func _on_end_timer_timeout():
	eyes.blink.play("Close")
	eyes.decider()
