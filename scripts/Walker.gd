extends Node
class_name  Walker

const DIRECTIONS = [Vector2.RIGHT,Vector2.UP,Vector2.LEFT,Vector2.DOWN]
var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_his = []
var steps_since_turn = 0
var rooms = []

func _init(starting_position , new_border):
	assert(new_border.has_point(starting_position))
	position = starting_position
	step_his.append(position)
	borders = new_border

func walk(steps):
	place_room(position)
	for step in steps:
		if  steps_since_turn >= 7:
			change_dir()
			
		if step() :
			step_his.append(position)
		else:
			change_dir()
	return step_his
func step():
	var target_pos = position+direction
	if borders.has_point(target_pos):
		steps_since_turn += 1
		position = target_pos
		return true
	else:
		return false
func change_dir():
	place_room(position)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	print(direction)
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

func place_room(position):
	var size = Vector2(randi()%4 + 2, randi()%4 + 2)
	var top_left_corner = (position - size/2).ceil()
	rooms.append(create_room(position,size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x,y)
			if borders.has_point(new_step):
				step_his.append(new_step)
func create_room(position,size):
	return {position = position, size = size}

func get_end_room():
	var end_room = rooms.pop_front()
	var start_pos = step_his.front()
	for room in rooms:
		if start_pos.distance_to(room.position) > start_pos.distance_to(end_room.position):
			end_room = room
	return end_room
