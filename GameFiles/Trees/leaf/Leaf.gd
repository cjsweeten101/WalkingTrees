extends Sprite

var speed = 10
var direction = Vector2(1,0)

signal game_over

func _on_Area2D_area_entered(area):
	if area.is_in_group("loggers"):
		emit_signal("game_over")

func _on_Experiation_timeout():
	queue_free()

func _physics_process(delta):
	translate(direction * speed)