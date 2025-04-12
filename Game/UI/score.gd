extends RigidBody2D

var ticker = false
@onready var goblin_head: Sprite2D = $GoblinHead
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D


func _ready() -> void:
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
