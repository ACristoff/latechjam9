class_name Pip extends Node2D

const PIP_SCENE: PackedScene = preload("res://Game/Pip/base_pip.tscn")



static func new_pip(type: String) -> Pip:
	print(type)
	var new_pip: Pip = PIP_SCENE.instantiate()
	return new_pip



func _ready():
	print('hallo')
