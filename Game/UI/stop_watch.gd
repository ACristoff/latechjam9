extends Node2D
@onready var timer: Timer = $Timer
@onready var stop_watch: Sprite2D = $StopWatch
@onready var timelab: Label = $Time
@onready var wiggle: AnimationPlayer = $Wiggle

var time = 30
func _ready() -> void:
	timelab.text = str(time)
	start()

func start():
	timer.start()

func _process(delta: float) -> void:
	if time <= 0:
		timer.stop()
		print("lose con")
		print(" call dont have it in eyes overlay")

func _on_timer_timeout() -> void:
	wiggle.play("wiggle")
	time -= 1
	timelab.text = str(time)
