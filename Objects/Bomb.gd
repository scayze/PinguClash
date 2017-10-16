extends RigidBody2D

var SCENE_BURST = preload("res://Objects/ParticleBombBurst.tscn")

var lifetime=0.0 setget set_Lifetime,get_Lifetime
func get_Lifetime():
	return lifetime
func set_Lifetime(v):
	lifetime = v

var MAXlifetime=2.5 setget,get_maxLifetime
func get_maxLifetime():
	return MAXlifetime

var sprite
var emitter
#200
var explosionSize = 170.0 setget ,get_explosionSize
func get_explosionSize():
	return explosionSize

var explosionStrength = 1200.0

func _ready():
	sprite = get_child(0)
	self.set_process(true)

func isDestroy():
	return true

func _process(delta):
	lifetime+=delta
	get_child(2).set_text(str(int(MAXlifetime-lifetime)))
	get_node("Label").add_color_override("font_color",Color(lifetime/MAXlifetime,1-lifetime/MAXlifetime,0))
	if(lifetime>MAXlifetime):
		explode()
		self.queue_free()
	
	
	if(lifetime<MAXlifetime/3):
		sprite.get_sprite_frames().set_animation_speed(sprite.get_animation(),1.5)
	elif(lifetime<MAXlifetime/3*2): 
		sprite.get_sprite_frames().set_animation_speed(sprite.get_animation(),3)
	else:
		sprite.get_sprite_frames().set_animation_speed(sprite.get_animation(),5)
		sprite.set_modulate(Color(0.9,0.1,0.1))

func explode():
	var bodies = get_parent().get_node("AllBodies").get_overlapping_bodies()
	var i=0
	while i < bodies.size():
		if(not bodies[i] is StaticBody2D):
			var dir = bodies[i].get_position() - self.get_position()
			var lsq = dir.length()
			if(lsq<=explosionSize):
				#bodies[i].apply_impulse(self.get_pos(),dir.normalized()* (1.0-(lsq/explosionSize)) * explosionStrength )
				bodies[i].apply_impulse(self.get_position(),dir.normalized()* explosionStrength/1.5 )
				if(bodies[i].has_method("set_HP")):
					bodies[i].set_HP(bodies[i].get_HP()-1)
		i+=1
	
	var burst= SCENE_BURST.instance()
	burst.set_position(get_position())
	get_parent().add_child(burst)








