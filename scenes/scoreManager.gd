extends Node
var enemies_def = 0
@onready var holder = $"../CanvasModulate"
@onready var enemies = $"../CanvasModulate/enemies"
var enem_no
var enems 
var rays
@onready var screen_anim = $"../screen_anim"
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
	
func _process(delta):
	if Global.power < 0:
		Global.power = 0
		screen_anim.play("game_over")
		#while Engine.time_scale == 0:
			#Engine.time_scale -= 0.01
		#Engine.time_scale = 0
		await screen_anim.animation_finished
		set_process_input(false)
