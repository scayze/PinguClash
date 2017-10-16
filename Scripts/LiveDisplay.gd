
extends Node2D

var prevHP = 0

func _ready():
	
	get_child(0).set_texture(load("res://fullHeart.png"))
	get_child(1).set_texture(load("res://fullHeart.png"))
	get_child(2).set_texture(load("res://fullHeart.png"))
	set_process(true)

func _process(delta):
	
	if(prevHP != get_parent().player.get_HP()):
		updateHP(get_parent().player.get_HP())
	prevHP = get_parent().player.get_HP()

func updateHP(hp):
	var i = 0
	while i<3:
		if(i<hp):
			get_child(i).set_texture(load("res://fullHeart.png"))
		else:
			get_child(i).set_texture(load("res://emptyHeart.png"))
		i+=1

