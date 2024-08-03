extends Area2D

var player
signal leaving_level
signal reload
#func _ready():
	#player = get_tree().get_first_node_in_group("player")
func _on_body_entered(body):
	player = get_tree().get_first_node_in_group("player")
	if body != null:
		if body == player:
			print("jak")
			leaving_level.emit()
		else:
			reload.emit()
