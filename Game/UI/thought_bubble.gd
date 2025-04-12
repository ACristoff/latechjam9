extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $CanvasLayer/Label
@onready var show_text: AnimationPlayer = $ShowText
@onready var show_text_timer: Timer = $ShowTextTimer

var debug_phrase = "My skin is sensitive. Who am I?"

func begin():
	animation_player.play("Begin")
	show_text_timer.start()
func ready():
	pass
	
func set_riddle(phrase):
	label.text = str(phrase)
	show_text.play("showtext")


func _on_show_text_timer_timeout() -> void:
	set_riddle(debug_phrase)
