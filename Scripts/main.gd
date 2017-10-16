extends Node2D

#Preload Scenes
var Scene_Bomb = preload("res://Objects/Bomb.tscn")
var Scene_PowerUp = preload("res://Objects/PowerUp.tscn")
var Scene_Player = preload("res://Objects/Player.tscn")

#The Player
var player

#Increment value
var incrementVal = 1

#Time since last BombDrop
var timeSinceDrop=0.0
var timeSincePowerUp = 0.0

#DisplayResolution
var res

#The Counter
var counter = 0
var paused = false

func _ready():
	#Randomize all values
	randomize()

	get_node("Plank/Highscore").set_text("Highscore: " + str(0))
	#get_node("Highscore").set_text("Highscore: " + str(float(int(Globals.get("score/high")*100))/100))
	
	#Instantiate Player
	player = Scene_Player.instance()
	add_child(player)
	
	#Save Game resolution in variable
	res = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	newGame()

func _process(delta):
	if not paused: counter += delta
	#Aluuah Akbar
	timeSinceDrop+=delta*incrementVal
	#if(timeSinceDrop>=0.2 + 0.5/ (1+counter*0.02)):
	if(timeSinceDrop>=0.2 + 0.3/ (1+counter*0.04)):
		dropBomb()
		timeSinceDrop=0.0
	#Increment PowerUp
	timeSincePowerUp+=delta*incrementVal
	if(timeSincePowerUp>=6.0):
		dropPowerUp()
		timeSincePowerUp=0.0
	#Set Labels
	get_node("Plank/Score").set_text("Time Alive: " + str(float(int(counter*100))/100))
	
	#Check for restart
	if(player.get_HP()<=0.0):
		newGame()

func dropPowerUp():
	#Instantiate
	var obj = Scene_PowerUp.instance()
	add_child(obj)
	#In display res
	obj.set_position(Vector2(rand_range(0,res.x),rand_range(0,res.y)))

#Drop a Bomb
func dropBomb():
	#Instantiate
	var obj = Scene_Bomb.instance()
	add_child(obj)
	#In display res
	obj.set_position(Vector2(rand_range(0+75,res.x-75),rand_range(0+75,res.y-75)))

#Restart Game
func newGame():
	#Update Highscore
	if(ProjectSettings.get_setting("score/high") < counter):
		ProjectSettings.set_setting("score/high",counter)
	get_node("Plank/Highscore").set_text("Highscore: " + str(float(int(ProjectSettings.get_setting("score/high")*100))/100))
	
	#Reset PowerUps
	get_node("Buttons").clear()
	#Reset player
	player.set_HP(3)
	player.set_position(res/2)
	#Update Bombtimer
	timeSinceDrop = 0
	
	#Restart Counter
	counter = 0
	
	#Delete All Bombs (not working)
	var bodies = get_node("AllBodies").get_overlapping_bodies()
	for body in bodies:
		if(body.isDestroy() and not body is StaticBody2D):
			body.queue_free()

func pause_time(b):
	if(b):
		incrementVal = 0
	else:
		incrementVal = 1
	
	var bodies = get_node("AllBodies").get_overlapping_bodies()
	for body in bodies:
		if(body.has_method("explode")):
			if(b==true):
				body.set_process(false)
				body.get_child(0).get_sprite_frames().set_animation_speed(body.get_child(0).get_animation(),0)
			else:
				body.set_process(true)

#On Destroy, save the config
func _exit_tree():
	ProjectSettings.save()



