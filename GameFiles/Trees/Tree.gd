extends KinematicBody2D

var speed = 900

func _ready():
	_set_tree_size("small")

func _set_tree_size(size):
	if size == "small":
		$small_collision.disabled = false
		$small_collision/small_sprite.visible = true

func _physics_process(delta):
	var direction = Vector2()
	var bodies = $AgroArea.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("loggers"):
			direction = body.current_direction
	move_and_slide(direction * speed)