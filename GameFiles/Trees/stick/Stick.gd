extends Sprite


signal game_over
	
func _free():
	self.queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("loggers"):
		emit_signal("game_over")

func swing_right():
	$AnimationPlayer.play("swing_right")

func swing_left():
	$AnimationPlayer.play("swing_left")