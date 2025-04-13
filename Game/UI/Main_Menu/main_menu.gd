extends Control

@onready var start: AnimationPlayer = $Start
@onready var startbutt: Button = $VBoxContainer/Start

func _on_start_pressed():
	start.play("Start")
	startbutt.disabled = true
	print("start")

func _on_settings_pressed():
	SignalBus.game_state_changed.emit("Settings")

func _on_credits_pressed():
	SignalBus.game_state_changed.emit("Credits")

func _on_quit_pressed():
	SignalBus.game_state_changed.emit("Quit")
	print("quit")


func _on_start_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Start":
		SignalBus.game_state_changed.emit("Start")
		queue_free()
