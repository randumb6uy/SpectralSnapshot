extends Node
var enemies_def = 0
@onready var holder = $"../CanvasModulate"
var enems = []
var rays
signal exit
func _ready():
	rays = get_tree().get_first_node_in_group("flashlight")
	rays.obj_in_sight.connect(on_sight)
	enems = Global.enemy_pool
	print(enems)
func on_sight(enemy):
	if enemies_def < holder.enemies.get_child_count():
		for i in enems:
			if i == enemy:
				enemies_def+=1
				holder.enemy_count.text = "Ghosts Found " + str(enemies_def)+ "/" + str(holder.enemies.get_child_count())
				enems.erase(i)
	elif enemies_def == len(Global.enemy_pool):
		exit.emit()
