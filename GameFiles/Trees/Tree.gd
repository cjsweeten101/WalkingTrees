extends KinematicBody2D

var speed = 40
var idle = true
var next_coord = Vector2()
var last_coord = Vector2()
var scared = true
var default_magnitude = 10
var run_direction = null
var run_time = 1200
var current_time = 0

func _ready():
	last_coord = position
	next_coord = last_coord
	_set_tree_size("small")

func _set_tree_size(size):
	if size == "small":
		$small_collision.disabled = false
		$small_collision/small_sprite.visible = true

func _physics_process(delta):
	update_state()
	pass

func update_state():
	print(run_direction)
	if current_time != run_time && run_direction != null:
		move_and_slide(run_direction * speed)
		print("runnin")
	var bodies = $AgroArea.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("loggers"):
			agro_state(body)
		else:
			print("idlin")
			idle_state()

func agro_state(body):
	if scared:
		calc_next_coord(body)
		pass
	else:
		print("shouldn't hit yet")
		pass	
	pass

func idle_state():
	run_direction = null

func calc_next_coord(body):
	if last_coord == next_coord:
		print("calculating new coord")
		run_direction = Vector2(position - body.position).normalized()
		#var run_path = Vector2(randi() % 100 + 25, randi() % 100 + 25)
		#run_path.x *= sign(run_direction.x)
		#run_path.y *= sign(run_direction.y)
		#next_coord = run_path
# Ok so FSM is basically this:
# Idle->(player enters agro area)->agrostate(running if small, attacking if big etc. . . maybe add more states)
# ->(Player leaves agro area)->Idle. 
# So should be pretty easy
# So just use an enum?  Or maybe use methods, no need to add an extra class.  Would be weird in godot,
# Also maybe I wont use an AI handler after all