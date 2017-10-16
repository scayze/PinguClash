extends Sprite

var outer
onready var player = get_parent().player
var MAX = 57

var state = false
var input_position = Vector2(0,0)

var eventCount = 0

var unitVec = Vector2(1,0)
var joyPos

func _ready():
	self.set_process_input(true)
	self.set_process(true)
	outer = self.get_node("outer")
	joyPos = self.get_position()

func _process(delta):
	if(state == true):
		var dist = joyPos.distance_to(input_position)
		var v = Vector2(input_position-joyPos)
		unitVec = v.normalized()
		if(dist >= MAX):
			outer.set_position(unitVec*MAX)
			player.set_linear_velocity(unitVec*player.speed)
		else:
			outer.set_position(v)
			player.set_linear_velocity(unitVec*player.speed*dist/MAX)
		#player.add_force(player.get_pos(),unitVec)
		
	else: 
		outer.set_position(Vector2(0,0))

	if(!state && player != null):
		player.set_linear_velocity(player.get_linear_velocity()*0.9*(1.0-delta))


func getVec():
	return unitVec

func _input(event):
	player = get_parent().player
	if(event is InputEventMouseButton || event is InputEventMouseMotion):
		if(event is InputEventMouseButton && event.pressed):
				state=true
		if(event is InputEventMouseButton && !event.pressed):
				state=false
		
		var buttons = get_parent().get_node("Buttons").get_children()
		for button in buttons:
			if(!button.get_rect().has_point(event.position)):
				if(event is InputEventMouseButton or event is InputEventMouseMotion):
					input_position = event.position
	
	


