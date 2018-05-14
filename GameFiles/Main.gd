extends Node2D

var logger_camera_position = Vector2(0,0)

var game_over = false

func _ready():
	randomize()


func _physics_process(delta):
	if !game_over:
		logger_camera_position = $Logger.camera_position()
		logger_win()
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
		var attacks = get_tree().get_nodes_in_group("attacks")
		for attack in attacks:
			if !attack.is_connected("game_over", self, "on_game_over"):
				attack.connect("game_over", self, "on_game_over")
	else:
		if Input.is_key_pressed(KEY_ENTER):
			get_tree().reload_current_scene()
		elif Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()

func logger_win():
	if get_tree().get_nodes_in_group("trees").size() == 0:
		$Game_over.text = "You win! \n press enter to play again"
		on_game_over()
		
func on_game_over():
	$Logger.queue_free()
	game_over = true
	$Game_over.visible = true