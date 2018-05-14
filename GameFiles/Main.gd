extends Node2D

var logger_camera_position = Vector2(0,0)

var game_over = false

func _ready():
	randomize()


func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	elif Input.is_key_pressed(KEY_ENTER) && game_over:
		get_tree().reload_current_scene()
	if !game_over:
		logger_camera_position = $Logger.camera_position()
	var attacks = get_tree().get_nodes_in_group("attacks")
	for attack in attacks:
		attack.connect("game_over", self, "on_game_over")
		
func on_game_over():
	$Logger.queue_free()
	game_over = true
	$Game_over.visible = true