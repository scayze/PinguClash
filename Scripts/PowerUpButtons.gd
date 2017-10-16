extends Node

var shield = preload("res://Objects/Shield.tscn")

var type = ["","",""]

var keys = [KEY_1,KEY_2,KEY_3]

var pauseTimer = 0


func _ready():
	self.set_process(true)
	self.set_process_input(true)
	for i in range(3):
		get_child(i).set_normal_texture(load("res://nothin.png"))

func add_powerUp(powerup):
	var emptyPowerUp = false
	for i in range(3):
		if(get_child(i).get_normal_texture().get_path() == "res://nothin.png"):
			get_child(i).set_normal_texture(powerup.get_node("Sprite").get_texture())
			type[i]=powerup.get_BuffType()
			emptyPowerUp = true
			break
	return emptyPowerUp

func _process(delta):
	if(pauseTimer > 0 and pauseTimer-delta < 0):
		get_parent().pause_time(false)
	pauseTimer-=delta

func clear():
	type = ["","",""]
	for i in range(3):
		get_child(i).set_normal_texture(load("res://nothin.png"))

func _input(event):
	if(Input.is_key_pressed(KEY_2)):
		get_child(1).set_pressed(true)
	if(Input.is_key_pressed(KEY_3)):
		get_child(2).set_pressed(true)
	
	for i in range(3):
		if(get_child(i).is_pressed() || Input.is_key_pressed(keys[i])):
			if(type[i] == "Invincible"):
				var pu = shield.instance()
				pu.set_duration(3)
				get_parent().player.add_child(pu)
				#get_parent().player.set_invincibleTimer(3)
				type[i]=""
			elif(type[i] == "StopTime"):
				get_parent().pause_time(true)
				pauseTimer = 3
				type[i]=""
			elif(type[i] == "Heal"):
				type[i]=""
				get_parent().player.set_HP(get_parent().player.get_HP()+1)
			elif(type[i] == "Destroy"):
				type[i]=""
				var bodies = get_parent().get_node("AllBodies").get_overlapping_bodies()
				for body in bodies:
					if(body.has_method("explode")):
						body.set_Lifetime(body.get_maxLifetime())
			
			get_child(i).set_normal_texture(load("res://nothin.png"))


