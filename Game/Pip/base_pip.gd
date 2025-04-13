class_name Pip extends CharacterBody2D

const PIP_SCENE: PackedScene = preload("res://Game/Pip/base_pip.tscn")

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $PipSprite
@onready var sprite_parent: Node2D = $ModularSprite 
@onready var body_sprite: Sprite2D = $ModularSprite/BodySprite2D
@onready var blush_sprite: Sprite2D = $ModularSprite/BlushSprite2D
@onready var ears_sprite: Sprite2D = $ModularSprite/EarsSprite2D
@onready var eyebrows_sprite: Sprite2D = $ModularSprite/EyebrowsSprite2D
@onready var mouth_sprite: Sprite2D = $ModularSprite/MouthSprite2D
@onready var eyes_sprite: Sprite2D = $ModularSprite/EyesSprite2D
@onready var hair_sprite: Sprite2D = $ModularSprite/HairFrontSprite2D
@onready var arms_sprite: Sprite2D = $ModularSprite/ArmsSprite2D
@onready var pant_sprite: Sprite2D = $ModularSprite/PantsSprite2D
@onready var shirt_sprite: Sprite2D = $ModularSprite/ShirtsSprite2D
@onready var shoes_sprite: Sprite2D = $ModularSprite/ShoesSprite2D

@export var speed = 250

var pipType: String = "none"

@onready var riddles = [
	preload("res://Assets/GoblinRiddles/riddle1.png"),
	preload("res://Assets/GoblinRiddles/riddle2.png"),
	preload("res://Assets/GoblinRiddles/riddle3.png"),
	preload("res://Assets/GoblinRiddles/riddle4.png"),
	preload("res://Assets/GoblinRiddles/riddle5.png"),
	preload("res://Assets/GoblinRiddles/riddle6.png"),
]

@onready var bodies = [
	preload("res://Assets/Sprites/Body/Body.png")
]
#@onready var blushes = [
	#preload("res://Assets/Sprites/Blush/Blush.png")
#]
@onready var ears = [
	preload("res://Assets/Sprites/Ears/Ears1.png"),
	preload("res://Assets/Sprites/Ears/Ears2.png")
]
@onready var eyebrows = [
	preload("res://Assets/Sprites/Eyebrows/Eyebrows1.png"),
	preload("res://Assets/Sprites/Eyebrows/Eyebrows2.png"),
	preload("res://Assets/Sprites/Eyebrows/Eyebrows3.png"),
]
@onready var mouths = [
	preload("res://Assets/Sprites/Mouths/Mouth1.png"),
]
@onready var eyes = [
	preload("res://Assets/Sprites/Eyes/Eyes1.png"),
	preload("res://Assets/Sprites/Eyes/Eyes2.png"),
	preload("res://Assets/Sprites/Eyes/Eyes3.png"),
	preload("res://Assets/Sprites/Eyes/Eyes4.png"),
	preload("res://Assets/Sprites/Eyes/Eyes5.png"),
	preload("res://Assets/Sprites/Eyes/Eyes6.png"),
	preload("res://Assets/Sprites/Eyes/Eyes7.png"),
	preload("res://Assets/Sprites/Eyes/Eyes8.png"),
]
@onready var hairtypes = [
	preload("res://Assets/Sprites/Hair front/Hair Front 1/HairFront1.png"),
	preload("res://Assets/Sprites/Hair front/Hair Front 2/HaiFront2.png"),
	preload("res://Assets/Sprites/Hair front/Hair Front 3/HairFront3.png"),
]
@onready var arms = [
	preload("res://Assets/Sprites/Arms/arms.png"),
]
@onready var pants = [
	preload("res://Assets/Sprites/Pants/Pants1.png"),
	preload("res://Assets/Sprites/Pants/Pants2.png"),
	preload("res://Assets/Sprites/Pants/Pants3.png")
]
@onready var shirts = [
	preload("res://Assets/Sprites/Shirts/Shirt1.png"),
	preload("res://Assets/Sprites/Shirts/Shirt2.png"),
	preload("res://Assets/Sprites/Shirts/Shirt3.png"),
]
@onready var shoes = [
	preload("res://Assets/Sprites/Shoes/Shoes1.png"),
	preload("res://Assets/Sprites/Shoes/Shoes2.png"),
]


static func new_pip(type: String) -> Pip:
	#print(type)
	var new_pip: Pip = PIP_SCENE.instantiate()
	new_pip.pipType = type
	if type == "civilian":
		#new_pip.randomize_pip()
		pass
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
	#if Input.is_action_just_pressed("debug"):
		#stop()
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()

func riddled(type):
	match type:
		0:
			eyes_sprite.texture = riddles[0]
			eyebrows_sprite.texture = riddles[0]
			mouth_sprite.texture = riddles[0]
		1:
			blush_sprite.texture = riddles[1]
		2: 
			eyebrows_sprite.texture = riddles[2]
			eyes_sprite.texture = riddles[2]
		3:
			blush_sprite.texture = riddles[3]
		4:
			ears_sprite.texture = riddles[4]
		5:
			hair_sprite.texture = riddles[5]
	pass

func randomize_pip():
	var body = bodies[randi_range(0, bodies.size() - 1)]
	#var blush = blushes[randi_range(0, blushes.size() - 1)]
	var ear = ears[randi_range(0, ears.size() - 1)]
	var eye = eyes[randi_range(0, eyes.size() - 1)]
	var eyebrow = eyebrows[randi_range(0, eyebrows.size() - 1)]
	var mouth = mouths[randi_range(0, mouths.size() - 1)]
	##TODO figure out what's going on with hair
	var hair = hairtypes[randi_range(0, hairtypes.size() - 1)]
	var arm = arms[randi_range(0, arms.size() - 1)]
	var pant = pants[randi_range(0, pants.size() - 1)]
	var shirt = shirts[randi_range(0, shirts.size() - 1)]
	var shoe = shoes[randi_range(0, shoes.size() - 1)]
	
	body_sprite.texture = body
	#blush_sprite.texture = blush
	ears_sprite.texture = ear
	eyes_sprite.texture = eye
	eyebrows_sprite.texture = eyebrow
	mouth_sprite.texture = mouth
	hair_sprite.texture = hair
	arms_sprite.texture = arm
	pant_sprite.texture = pant
	shirt_sprite.texture = shirt
	shoes_sprite.texture = shoe
	pass
