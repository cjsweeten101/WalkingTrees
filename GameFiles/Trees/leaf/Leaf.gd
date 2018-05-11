extends Sprite

var speed = 10
var direction = Vector2(1,0)

func _on_Area2D_area_entered(area):
	if area.is_in_group("loggers"):
		var logger = get_node("/root/Main/Logger")
		logger.queue_free()

func _on_Experiation_timeout():
	queue_free()

func _physics_process(delta):
	translate(direction * speed)