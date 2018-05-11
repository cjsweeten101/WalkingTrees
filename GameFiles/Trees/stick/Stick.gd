extends Sprite


func _ready():
	print(position)
	
func _free():
	self.queue_free()


func _on_Area2D_area_entered(area):
	if area.is_in_group("loggers"):
		var logger = get_node("/root/Main/Logger")
		logger.queue_free()

func swing_right():
	$AnimationPlayer.play("swing_right")

func swing_left():
	$AnimationPlayer.play("swing_left")
	