extends Node
var enemies_def = 0
@onready var holder = $"../CanvasModulate"
@onready var enemies = $"../CanvasModulate/enemies"
var enem_no
var enems 
var rays
signal exit
func _ready():
	enems = enemies.get_children()
	enem_no = enemies.get_child_count()
	print(len(enems))
	rays = get_tree().get_first_node_in_group("flashlight")
	rays.obj_in_sight.connect(on_sight)
	print(enems)
func on_sight(enemy):
	if enemies_def < holder.enemies.get_child_count() && enemy in enems:
		print(enems)
		enemies_def+=1
		holder.enemy_count.text = "Ghosts Found " + str(enemies_def)+ "/" + str(holder.enemies.get_child_count())
		enems.erase(enemy)
	
