extends Node2D

@onready var HEAD = preload("res://Game/UI/score.tscn")
@onready var head_spawn: Marker2D = $HeadSpawn
@onready var label: Label = $Label
@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var timer: Timer = $Timer


var ticker = true
var score = 0
var score_true = 0

func add_score():
	score_true += 1
	label.text = str(score_true)
	if score == 5:
		static_body_2d.set_collision_layer_value(1, false)
		timer.start()
	else:
		var score_head = HEAD.instantiate()
		add_child(score_head)
		score_head.global_position = head_spawn.global_position
		if ticker == true:
			score_head.ticker = true
			ticker = false
		else:
			score_head.ticker = false
		ticker = true
		score += 1

func _on_score_up_pressed() -> void:
	add_score()
	
func _on_timer_timeout() -> void:
	score = 1
	static_body_2d.set_collision_layer_value(1, true)
	var score_head = HEAD.instantiate()
	add_child(score_head)
	score_head.global_position = head_spawn.global_position
