extends Sprite

func free():
	self.queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("loggers"):
		body.queue_free()
