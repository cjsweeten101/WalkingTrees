extends KinematicBody2D

var speed = 900
var idle = true
var next_coord = Vector2()
var scared = true
var default_magnitude = 10

func _ready():
	_set_tree_size("small")

func _set_tree_size(size):
	if size == "small":
		$small_collision.disabled = false
		$small_collision/small_sprite.visible = true

func _physics_process(delta):
	#update state, somehow return movement data maybe?
	#hmmm that may be a bit tricky
	update_state()
	pass

func update_state():
	var bodies = $AgroArea.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("loggers"):
			agro_state(body)
		else:
			idle_state()

func agro_state(body):
	if scared:
		next_coord = calc_next_coord(body)
		pass
	else:
		print("shouldn't hit yet")
		pass	
	pass

func idle_state():
	pass

func calc_next_coord(body):
	print(body.position)
# Ok so FSM is basically this:
# Idle->(player enters agro area)->agrostate(running if small, attacking if big etc. . . maybe add more states)
# ->(Player leaves agro area)->Idle. 
# So should be pretty easy
# So just use an enum?  Or maybe use methods, no need to add an extra class.  Would be weird in godot,
# Also maybe I wont use an AI handler after all