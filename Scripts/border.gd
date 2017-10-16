extends Sprite

var expsize
func _ready():
	self.set_process(true)
	expsize = get_parent().get_explosionSize()
	self.set_scale(Vector2(expsize/self.get_texture().get_width(),expsize/self.get_texture().get_width()) *2)

func _process(delta):
	modulate = Color(1,1,1,get_parent().get_Lifetime() / get_parent().get_maxLifetime())
	if(get_parent().get_Lifetime()>=get_parent().get_maxLifetime()-0.1):
		update()