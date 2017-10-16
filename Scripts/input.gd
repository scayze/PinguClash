
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process_input(true)
	self.set_process(true)
	pass

func _input(event):
	if(event.type == InputEvent.SCREEN_TOUCH):
		self.set_pos(event.pos)
		
func _process(delta):
	self.set_pos(self.get_pos()+Vector2(1,1))


