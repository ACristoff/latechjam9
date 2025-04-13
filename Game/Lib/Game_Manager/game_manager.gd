extends Node

class_name Game_Manager

##TODO Erase these comments when you're done setting up the audio manager
##Game Manager:
##This node is not necessarily meant to be an autoload, but rather sit at the top of the node hierarchy
##Nodes get switched out as children of this node and this is where game-wide data is stored
##By default, you'd put the node configuration of what is meant to run on launch and have things loop back to main menu

#Activates or deactivates the debug mode
@export var debug_mode: bool = false
@onready var score = $ScoreTracker
#Where all menu UIs are rendered
#Set to run always
@onready var menu_ui: CanvasLayer = $MenuUI

@onready var main_menu = preload("res://Game/UI/Main_Menu/main_menu.tscn")
@onready var game = preload("res://Game/World/pip_world.tscn")

@onready var current_menu = $Transitions/Splash
@onready var game_host = $GameHost


#Dictionary that holds all the relevant menus we will be switching through
@onready var Menu_Scenes: Dictionary = {
	"Main": main_menu,
	"Start": game,
	"Quit": 'Quit za gameo'
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.game_state_changed.connect(change_scene.bind())
	SignalBus.show_score.connect(on_show_score.bind())
	SignalBus.game_state_changed.emit("Main")
	SignalBus.hide_score.connect(on_hide_score.bind())
	SignalBus.new_level.connect(on_new_level.bind())

func on_new_level():
	var new_scene = Menu_Scenes.Start.instantiate()
	game_host.add_child(new_scene)

func on_show_score():
	score.visible = true

func on_hide_score():
	score.visible = false

func change_scene(new_state: String):
	if debug_mode == true:
		prints('scene changed', new_state, Menu_Scenes[new_state])
	if new_state == "Quit":
		get_tree().quit()
	if new_state == "Start":
		var new_scene = Menu_Scenes[new_state].instantiate()
		game_host.add_child(new_scene)
		return
	if Menu_Scenes[new_state] is not String:
		var new_scene = Menu_Scenes[new_state].instantiate()
		menu_ui.add_child(new_scene)
