extends CanvasModulate

func _ready():
	self.set_process(false)

func _process(delta):
	self.set_opacity(get_parent().get_Lifetime() / get_parent().get_maxLifetime())
	if(get_parent().get_Lifetime()>=get_parent().get_maxLifetime()-0.1):
		update()

func _draw():
	draw_empty_circle(self.get_position(),get_parent().get_explosionSize())
	
	if(get_parent().get_Lifetime()>=get_parent().get_maxLifetime()-0.1):
		draw_circle(self.get_position(),get_parent().get_explosionSize(),Color(0.8,0,0,0.4))


func draw_empty_circle(center, radius):
	var i = 0
	var oldx = 0.0
	var oldy = -radius
	while(i<=35):
		var x = center.x +(radius*sin(0.18*i));
		var y = center.y -(radius*cos(0.18*i));
		draw_line(Vector2(oldx,oldy),Vector2(x,y),Color(0.2,0.2,0.2,0.8))
		oldx = x
		oldy = y
		i+=1



