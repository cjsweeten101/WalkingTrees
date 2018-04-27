extends KinematicBody2D

var max_speed = 500
var chainsaw = preload("res://Logger/Chainsaw/Chainsaw.tscn")
var facing = "right"

func _ready():
	chainsaw = chainsaw.instance()
	chainsaw.position.x += 64
	add_child(chainsaw)

func _physics_process(delta):
	var direction = Vector2()
	
	if Input.is_action_pressed("logger_move_down"):
		direction.y = 1
	if Input.is_action_pressed("logger_move_up"):
		direction.y = -1
	if Input.is_action_pressed("logger_move_right"):
		direction.x = 1
		facing = "right"
	if Input.is_action_pressed("logger_move_left"):
		direction.x = -1
		facing = "left"
	
	_flip_chainsaw()
	var current_speed = direction.normalized() * max_speed
	move_and_slide(current_speed)

func _flip_chainsaw():
	if facing == "left":
		if chainsaw.scale.x > 0:
			chainsaw.scale.x *= -1
			chainsaw.position.x *= -1
	elif facing == "right":
		if chainsaw.scale.x < 0:
			chainsaw.scale.x *= -1
			chainsaw.position.x *= -1
	