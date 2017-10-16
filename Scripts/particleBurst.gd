
extends Particles2D

var counter = 0

func _process(delta):
	counter += delta
	if(counter >= 0.55):
		queue_free()
	


