extends RigidBody2D

var ticker = false
@onready var goblin_head: Sprite2D = $GoblinHead
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var bleed_timer: Timer = $BleedTimer
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	bleed_timer.start()
	var rot = randi_range(0, 360)
	goblin_head.rotation_degrees = rot
	var randscale = randi_range(1, 2)
	if randscale == 1:
		print("true")
		goblin_head.scale = Vector2(-.145, .145)
		collision_polygon_2d.scale = Vector2(-1, 1)
		ticker = false
	else:
		print("false")
		goblin_head.scale = Vector2(.145, .145)
		collision_polygon_2d.scale = Vector2(1, 1)
		ticker = true


func _on_bleed_timer_timeout() -> void:
	gpu_particles_2d.bleed()
	animation_player.play("blood")
