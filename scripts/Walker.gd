extends Node
class_name  Walker
const enemy = preload("res://scenes/enemy.tscn")
const DIRECTIONS = [Vector2.RIGHT,Vector2.UP,Vector2.LEFT,Vector2.DOWN]
var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_his = []
var steps_since_turn = 0
var rooms = []
var rooms_with_enemy = []
var monster_rooms = []
var treasure_rooms = []

func _init(starting_position , new_border):
	assert(new_border.has_point(starting_position))
	position = starting_position
	step_his.append(position)
	borders = new_border

func walk(steps):
	place_room(position , 1)
	var v = 1
	for step in steps:
		if  steps_since_turn >= 10 and randf() >= 0.25:
			v += 1
			change_dir(v)
		if step() :
			step_his.append(position)
		else:
			v += 1
			change_dir(v)
	rooms_with_enemy  = rooms
	rooms_with_enemy.pop_front()
	return step_his
func step():
	var target_pos = position+direction
	if borders.has_point(target_pos):
		steps_since_turn += 1
		position = target_pos
		return true
	else:
		return false
func change_dir(index):
	place_room(position,index)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

	
func place_room(position,index):
	var size = Vector2(randi()%6 + 2, randi()%6 + 2)
	var top_left_corner = (position - size/2).ceil()
	rooms.append(create_room(position,size,index))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x,y)
			if borders.has_point(new_step):
				step_his.append(new_step)
func create_room(position,size,index):
	return {position = position, size = size , index = index}
func get_end_room():
	var end_room = rooms.pop_front()
	var start_pos = step_his.front()
	for room in rooms:
		if start_pos.distance_to(room.position) > start_pos.distance_to(end_room.position):
			end_room = room
			rooms_with_enemy.erase(room)
	return end_room

func place_monsters():
	for room in rooms_with_enemy:
		if randf() < Global.monster_room_chance: 
			monster_rooms.append(room)
			rooms_with_enemy.erase(room)
	var c = rooms_with_enemy.pick_random()
	monster_rooms.append(c)
	rooms_with_enemy.erase(c)
	return monster_rooms
	
func place_treasure():
	for room in rooms_with_enemy:
		if treasure_rooms.size() <= Global.max_treasures:
			if randf() < Global.treasure_room_chances: 
				treasure_rooms.append(room)
				rooms_with_enemy.erase(room)
	return treasure_rooms
