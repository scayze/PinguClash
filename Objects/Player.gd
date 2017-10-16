extends RigidBody2D

export var health = 3 setget set_HP,get_HP

var invincibleTimer = 0.0 setget set_invincibleTimer,get_invincibleTimer

var speed = 250.0

func _ready():
	pass

func _process(delta):
	invincibleTimer-=delta
	var vec = get_parent().get_node("Joystick").getVec()
	get_child(0).set_rotation(vec.angle())

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.has_method("get_BuffType"):
			if get_parent().get_node("Buttons").add_powerUp(body):
				body.queue_free()

func isDestroy():
	return false

func set_HP(hp):
	if(hp>health && hp<=3):
		health = hp 
	if(hp<health and invincibleTimer <= 0):
		health = hp 
		invincibleTimer = 0.5

func get_HP():
	return health

func set_invincibleTimer(t):
	invincibleTimer = t

func get_invincibleTimer():
	return invincibleTimer


