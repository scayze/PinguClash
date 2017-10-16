
extends Node

var play
var options
var exit

func _ready():
	play = get_node("Play")
	options = get_node("Options")
	exit = get_node("Exit")

	set_process_input(true)


func _input(event):
	#if(event.type == InputEvent.SCREEN_TOUCH):# && !event.pressed):
		if(play.is_pressed()):
			get_tree().change_scene("res://Objects/World.tscn")
		if(options.is_pressed()):
			get_tree().change_scene("res://Scenes/Options.tscn")
		if(exit.is_pressed()):
			get_tree().quit()

