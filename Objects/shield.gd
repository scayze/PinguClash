extends CanvasModulate

var duration = 1

func _ready():
	set_process(true)

func _draw():
	draw_circle(get_position(),50,Color(0.4,0.4,1,0.5))

func set_duration(t):
	duration = t

func _process(delta):
	get_parent().set_invincibleTimer(0.1)
	duration-=delta
	
	if(duration<=0):
		self.queue_free()


