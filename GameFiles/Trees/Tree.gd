extends KinematicBody2D

var stick = preload("res://Trees/stick/Stick.tscn")
var leaf = preload("res://Trees/leaf/Leaf.tscn")

var speed = 350
var idle = false
var scared = true
var run_direction = Vector2(0,0)
var size = "small"
var can_attack = true
var has_init_direction = true
var rand_direction = Vector2(0,0)
var current_sprite = null

#
func _ready():
	_set_tree_size(size)
	randomize()
	rand_direction = calc_rand_direction()

func _set_tree_size(size):
	if size == "small":
		$small_collision.disabled = false
		if !idle:
			$small_collision/small_sprite.visible = true
			current_sprite = $small_collision/small_sprite
			$small_collision/small_planted.visible = false
		else:
			$small_collision/small_planted.visible = true
			$small_collision/small_sprite.visible = false
	elif size == "medium":
		$small_collision.disabled = true
		$small_collision/small_sprite.visible = false
		$small_collision/small_planted.visible = false
		$medium_collision.disabled = false
		if !idle:
			$medium_collision/medium_sprite.visible = true
			current_sprite = $medium_collision/medium_sprite
			$medium_collision/medium_planted.visible = false
		else:
			$medium_collision/medium_planted.visible = true
			$medium_collision/medium_sprite.visible = false
	elif size == "large":
		$large_collision.disabled = false
		if !idle:
			$large_collision/large_sprite.visible = true
		else:
			$large_collision/large_planted.visible = true

func _physics_process(delta):
	if run_direction.x < 0:
		if current_sprite.scale.x > 0:
			current_sprite.scale.x *= -1
	elif run_direction.x > 0:
		if current_sprite.scale.x < 0:
			current_sprite.scale.x *= -1
	if has_init_direction:
		move_and_slide(rand_direction * speed)
	update_state()

func update_state():
	_set_tree_size(size)
	var agro = false
	move_and_slide(run_direction * speed)
	var bodies = $AgroArea.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("loggers"):
			agro = true
			agro_state(body)
	if agro == false && !has_init_direction:
		
		idle_state()

func agro_state(body):
	idle = false
	has_init_direction = false
	$growth_timer.paused = true
	if scared:
		calc_next_run_coord(body)
	else:
		attack(body, size)	

func attack(body, size):
	run_direction = Vector2(body.position - position).normalized()
	if can_attack:
		if size == "medium":
			stick_attack()
		elif size == "large":
			leaf_attack()
		can_attack = false
		$attack_timer.start()

func idle_state():
	idle = true
	run_direction = Vector2(0,0)
	if $growth_timer.is_stopped():
		$growth_timer.start()
	else:
		$growth_timer.paused = false

func calc_next_run_coord(body):
	run_direction = Vector2(position - body.position).normalized()
	

func _on_growth_timer_timeout():
	if size == "small":
		size = "medium"
		speed = 300
		#For debug always set scared to false
		if randi()%2 > 0:
			scared = false
			_increase_agro_size()
	elif size == "medium":
		size = "large"
		speed = 250
		scared = false
		_increase_agro_size()
	_set_tree_size(size)
	$growth_timer.stop()

func _increase_agro_size():
	var shape = CircleShape2D.new()
	shape.set_radius(10000)
	$AgroArea/CollisionShape2D.shape = shape
	
func stick_attack():
	var attack = stick.instance()
	if sign(run_direction.x) == -1:
		attack.swing_left()
		attack.position.x += -32
	else:
		attack.swing_right()
		attack.position.x += 32
	add_child(attack)

func leaf_attack():
	var attack = leaf.instance()
	attack.direction = run_direction
	add_child(attack)

func _on_change_from_idle_timeout():
	pass

func _on_walk_timer_timeout():
	has_init_direction = false
	
func _on_attack_timer_timeout():
	can_attack = true

func calc_rand_direction():
	var result = Vector2(randf(), randf())
	if randi() % 2 > 0:
		result.x *= -1
	elif randi() % 2 > 0:
		result.y *= -1
	return result.normalized()