extends Node2D
var spawned = false


@export var openDir : int
var timer 
var room_holder
@onready var sp_area = $Area2D

func _ready():
	
	room_holder = get_tree().get_nodes_in_group("Holder")[0]
	timer = get_tree().get_nodes_in_group("timer")[0]
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	sp_area.area_entered.connect(_on_overlap)
func spawn():
	if spawned == false:
			if openDir == 1:
				var i = Global.bottom_rooms.pick_random().instantiate()
				room_holder.add_child(i)
				i.position = position
				print(position)
			elif openDir == 2:
				var i = Global.left_rooms.pick_random().instantiate()
				room_holder.add_child(i)
				i.position = position
				print(position)
			elif openDir == 3:
				var i = Global.top_rooms.pick_random().instantiate()
				room_holder.add_child(i)
				i.position = position
				print(position)
			elif openDir == 4:
				var i = Global.right_rooms.pick_random().instantiate()
				room_holder.add_child(i)
				i.position = position
				print(position)
			spawned = true


func _on_timer_timeout():
	spawn()
	timer.start()
func _on_overlap(body):
	if body.is_in_group("spawnpoint") && body.get_parent().spawned == true :

		queue_free()
