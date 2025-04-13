extends Node2D

@onready var HEAD = preload("res://Game/UI/score.tscn")
@onready var head_spawn: Marker2D = $HeadSpawn
@onready var label: Label = $Label
@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var timer: Timer = $Timer
@onready var sound_time: Timer = $SoundTime
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $SoundTime/AudioStreamPlayer2D
@onready var pike: Sprite2D = $Pike


var blood_material: ShaderMaterial
var blood_material2: ShaderMaterial
var threshold
var threshold2
var firecombo: ShaderMaterial
var firepower

var ticker = true
var score = 0
var score_true = 0

func _ready() -> void:
	blood_material = pike.material as ShaderMaterial
	threshold = blood_material.get_shader_parameter("splatter_threshold")
	blood_material2 = label.material as ShaderMaterial
	threshold2 = blood_material.get_shader_parameter("splatter_threshold")
	

func add_score():
	score_true += 1
	label.text = str(score_true)
	threshold2 += .05
	blood_material2.set_shader_parameter("splatter_threshold", threshold2)
	if score == 5:
		static_body_2d.set_collision_layer_value(1, false)
		for i in range(10):
			threshold -= .1
			blood_material.set_shader_parameter("splatter_threshold", threshold)
			await get_tree().create_timer(.1).timeout
		timer.start()
	else:
		sound_time.start()
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
	sound_time.start()
	score = 1
	static_body_2d.set_collision_layer_value(1, true)
	var score_head = HEAD.instantiate()
	add_child(score_head)
	score_head.global_position = head_spawn.global_position


func _on_sound_time_timeout() -> void:
	threshold += .2
	audio_stream_player_2d.play()
	blood_material.set_shader_parameter("splatter_threshold", threshold)
