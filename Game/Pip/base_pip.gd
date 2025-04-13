class_name Pip extends CharacterBody2D

const PIP_SCENE: PackedScene = preload("res://Game/Pip/base_pip.tscn")

@onready var sprite: Sprite2D = $PipSprite
@onready var sprite_parent: Node2D = $ModularSprite 

@export var speed = 250

var pipType: String = "none"

#var stop: bool = false


static func new_pip(type: String) -> Pip:
	print(type)
	var new_pip: Pip = PIP_SCENE.instantiate()
	new_pip.pipType = type
	return new_pip

func stop():
	velocity = Vector2.ZERO


func _ready():
	#print('hallo', speed)
	pass

func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
