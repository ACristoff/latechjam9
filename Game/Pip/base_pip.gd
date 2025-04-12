class_name Pip extends Node2D

const PIP_SCENE: PackedScene = preload("res://Game/Pip/base_pip.tscn")



func new_pip(type: String) -> void:
	print(type)
	var new_pip: Pip = PIP_SCENE.instantiate()



func _ready():
	print('hallo')
