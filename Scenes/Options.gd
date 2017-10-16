extends Node

var sound

func _ready():
	sound = get_node("Sound")

func reset_pressed():
	ProjectSettings.set_setting("score/high",0)
	pass

func back_pressed():
	get_tree().change_scene("res://Scenes/MainMenue.tscn")
	pass
