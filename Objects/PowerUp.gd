extends RigidBody2D

var type setget set_BuffType,get_BuffType
var health = 2 setget set_HP,get_HP

func _ready():
	set_process(true)
	
	randomize()
	var r = int(rand_range(1,5))
	if(r==1):
		type = "Invincible"
	elif(r==2):
		type = "StopTime"
	elif(r==3):
		type = "Heal"
	elif(r==4):
		type = "Destroy"
	loadTex()

func isDestroy():
	return true

func _process(delta):
	if(health<=0):
		queue_free()

func set_BuffType(t):
	type = t

func get_BuffType():
	return type

func set_HP(hp):
	health = hp

func get_HP():
	return health

func loadTex():
	var sprite = get_node("Sprite")
	if(type=="Invincible"):
		sprite.set_texture(load("res://pu_shield.png"))
	elif(type=="StopTime"):
		sprite.set_texture(load("res://pu_stoptime.png"))
	elif(type=="Heal"):
		sprite.set_texture(load("res://pu_heal.png"))
	elif(type=="Destroy"):
		sprite.set_texture(load("res://pu_destroy.png"))
	else:
		sprite.set_texture(load("res://nothin.png"))
