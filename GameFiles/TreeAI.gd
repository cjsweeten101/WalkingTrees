extends Node2D

var trees = []
func _ready():
	trees = get_tree().get_nodes_in_group("trees")

func _process(delta):
	
	pass
