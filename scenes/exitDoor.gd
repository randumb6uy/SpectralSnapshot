extends Area2D

var player
var manager
signal leaving_level
signal reload
	
	
func _on_body_entered(body):
	player = get_tree().get_first_node_in_group("player")
	manager = get_tree().get_first_node_in_group("manager")
	print("JHG" + str(len(manager.enems)))
	print(player)
	if (len(manager.enems) <= 0 && (body == player))or (body.is_in_group("wall")):
		#if body == player:
		print("jak")
			#leaving_level.emit()
		#elif !body.is_in_group("enemy") :
		reload.emit()
 
