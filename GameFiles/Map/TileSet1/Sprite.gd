extends Sprite

func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		z_index = 1
	else:
		z_index = 0