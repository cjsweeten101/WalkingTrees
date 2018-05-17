extends KinematicBody2D

var max_speed = 500
var chainsaw = preload("res://Logger/Chainsaw/Chainsaw.tscn")
var facing = "right"
var can_dash = true
export var current_direction = Vector2()

func _ready():
	chainsaw = chainsaw.instance()
	chainsaw.position.x += 54
	add_child(chainsaw)
	z_index = 1

func _physics_process(delta):
	var direction = Vector2()
	
	if Input.is_action_pressed("logger_move_down"):
		direction.y = 1
	if Input.is_action_pressed("logger_move_up"):
		direction.y = -1
	if Input.is_action_pressed("logger_move_right"):
		direction.x = 1
		facing = "right"
		if $Sprite.scale.x < 0:
			$Sprite.scale.x *= -1
	if Input.is_action_pressed("logger_move_left"):
		direction.x = -1
		facing = "left"
		if $Sprite.scale.x > 0:
			$Sprite.scale.x *= -1
	if Input.is_action_pressed("logger_dash") && can_dash:
		can_dash = false
		chainsaw.texture = load("res://Logger/Chainsaw/chainsaw_red.png")
		max_speed = 1500
		$dash_cooldown.start()
		$dash_duration.start()
	_flip_chainsaw()
	current_direction = direction.normalized()
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

func camera_position():
	return $Camera2D.global_position

func get_camera():
	return $Camera2D

func _on_dash_duration_timeout():
	max_speed = 500


func _on_dash_cooldown_timeout():
	chainsaw.texture = load("res://Logger/Chainsaw/chainsaw_green.png")
	can_dash = true
