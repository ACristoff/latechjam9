extends Node2D

class_name Eyes

signal eyes_open

@onready var label: Label = $CanvasLayer/Label
@onready var label_2: Label = $CanvasLayer/Label2
@onready var label_3: Label = $CanvasLayer/Label3
@onready var timer_1: Timer = $CanvasLayer/Label/Timer1
@onready var timer_2: Timer = $CanvasLayer/Label2/Timer2
@onready var timer_3: Timer = $CanvasLayer/Label3/Timer3
@onready var animation_player: AnimationPlayer = $CanvasLayer/Label2/AnimationPlayer
@onready var blink: AnimationPlayer = $Blink
@onready var thought_bubble: Control = $CanvasLayer/ThoughtBubble
@onready var mouse_follow: Sprite2D = $MouseFollow
@onready var left: Area2D = $MouseFollow/EyeNormal/LeftEye
@onready var right: Area2D = $MouseFollow/EyeNormal/RightEye

@onready var DEMONSFX = preload("res://Assets/SFX/demon_sound.tscn")
@onready var demon: AudioStreamPlayer2D = $Demon
@onready var rising: AudioStreamPlayer2D = $Rising
@onready var have: AudioStreamPlayer2D = $HAVE
@onready var dont: AudioStreamPlayer2D = $DONT
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var len2
var len3
var have_mode = false
var target_pos
var speed = 250
var tracking = true


func _ready() -> void:
	label.add_theme_font_override("font", load("res://Assets/Fonts/runic.otf"))
	label_2.add_theme_font_override("font", load("res://Assets/Fonts/runic.otf"))
	label_3.add_theme_font_override("font", load("res://Assets/Fonts/runic.otf"))

var show_ratio

func decider():
	if have_mode == true:
		have_it()
	else:
		dont_have_it()

func have_it():
	have_mode = true
	label.visible_ratio = 0
	label_2.visible_ratio = 0
	label_3.visible_ratio = 0
	var phrase1 = "THE EYES"
	var phrase2 = "HAVE"
	var phrase3 = "IT"
	label.text = phrase1
	label_2.text = phrase2
	label_3.text = phrase3
	var len1 = len(str(phrase1))
	len2 = len(str(phrase2))
	len3 = len(str(phrase3))
	show_ratio = float(1) / float(len1)
	show_ratio = snapped(show_ratio, 0.01)
	print(show_ratio)
	timer_1.start()
	
func dont_have_it():
	have_mode = false
	label.visible_ratio = 0
	label_2.visible_ratio = 0
	label_3.visible_ratio = 0
	var phrase1 = "THE EYES"
	var phrase2 = "DONT"
	var phrase3 = "HAVE IT"
	label.text = phrase1
	label_2.text = phrase2
	label_3.text = phrase3
	var len1 = len(str(phrase1))
	len2 = len(str(phrase2))
	len3 = len(str(phrase3))
	show_ratio = float(1) / float(len1)
	show_ratio = snapped(show_ratio, 0.01)
	print(show_ratio)
	timer_1.start()

func _on_timer_1_timeout() -> void:
	demon.pitch_scale = .8
	if label.visible_ratio < 1:
		demon_noise()
		label.visible_ratio += show_ratio
	else:
		timer_1.stop()
		timer_2.start()


func _on_button_pressed() -> void:
	dont_have_it()
	
func demon_noise():
	var demonnoise = DEMONSFX.instantiate()
	add_child(demonnoise)

func _on_timer_2_timeout() -> void:
	demon.pitch_scale = .5
	if label_2.visible_ratio < 1:
		demon_noise()
		show_ratio = float(1) / float(len2)
		show_ratio = snapped(show_ratio, 0.01)
		label_2.visible_ratio += show_ratio
	else:
		timer_2.stop()
		timer_3.start()


func _on_timer_3_timeout() -> void:
	demon.pitch_scale = .8
	if label_3.visible_ratio < 1:
		demon_noise()
		show_ratio = float(1) / float(len3)
		show_ratio = snapped(show_ratio, 0.01)
		label_3.visible_ratio += show_ratio
	else:
		timer_3.stop()
		rising.play()
		animation_player.play("Reveal")
		
		
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "End":
		blink.play("Open")
		eyes_open.emit()
	if anim_name == "Reveal":
		if have_mode == true:
			have.play()
			label.add_theme_font_override("font", load("res://Assets/Fonts/sanctuary.regular.ttf"))
			label.pivot_offset = label.size/2
			label_2.add_theme_font_override("font", load("res://Assets/Fonts/sanctuary.regular.ttf"))
			label_2.pivot_offset = label.size/2
			label_3.add_theme_font_override("font", load("res://Assets/Fonts/sanctuary.regular.ttf"))
			label_3.pivot_offset = label.size/2
			await get_tree().create_timer(2).timeout
			canvas_layer.visible = false
			show_score()
			SignalBus.add_score.emit()
		else:
			dont.play()
			label.add_theme_font_override("font", load("res://Assets/Fonts/sanctuary.regular.ttf"))
			label.pivot_offset = label.size/2
			label_2.add_theme_font_override("font", load("res://Assets/Fonts/sanctuary.regular.ttf"))
			label_2.pivot_offset = label.size/2
			label_3.add_theme_font_override("font", load("res://Assets/Fonts/sanctuary.regular.ttf"))
			label_3.pivot_offset = label.size/2
			await get_tree().create_timer(2).timeout
			canvas_layer.visible = false
			show_score()

func show_score():
	SignalBus.show_score.emit()
	pass

func revelation():
	thought_bubble.begin()

func _on_blink_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Close":
		pass
		
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position().clamp(Vector2(500, 100), Vector2(780, 650))
	var dejitter = 2
	if Vector2i(mouse_follow.global_position).x > Vector2i(mouse_pos).x + dejitter|| Vector2i(mouse_follow.global_position).x < Vector2i(mouse_pos).x - dejitter || Vector2i(mouse_follow.global_position).y > Vector2i(mouse_pos).y + dejitter || Vector2i(mouse_follow.global_position).y < Vector2i(mouse_pos).y - dejitter:
		if tracking == true:
			mouse_follow.global_position += mouse_follow.global_position.direction_to(mouse_pos) * speed * delta

func get_colliders():
	var arr = []
	if left.get_overlapping_bodies():
		for body in left.get_overlapping_bodies():
			arr.append(body)
	if right.get_overlapping_bodies():
		for body in right.get_overlapping_bodies():
			arr.append(body)
	return arr
