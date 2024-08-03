extends  CanvasModulate
@onready var Transition = $Transition

const Enemy = preload("res://scenes/enemy.tscn")
var borders = Rect2(1 , 1 , 40 , 24 )
const Player = preload("res://scenes/player.tscn")
@onready var tile_map = $NavigationRegion2D/TileMap
const exitDoor = preload("res://scenes/exit.tscn")
@onready var nav_region = $NavigationRegion2D
@onready var color_rect = $"../ColorRect2"
@onready var animation_player = $"../AnimationPlayer"
@onready var floor_level = $"../CanvasLayer2/Panel/Label"
@onready var enemies = $enemies
@onready var enemy_count = $"../CanvasLayer2/enemyCount/Label"
var enemies_caught = 0
var floor_sizes = [ [200 ,10 ] , [500,5] , [100,15]]
var room_
var enemy_pool
var passable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	passable = false
	enemy_pool = enemies.get_children()
	floor_level.text = "floor 0 "
	color_rect.visible = true
	floor_level.visible = false
	randomize()
	generate_level()
	await get_tree().create_timer(2).timeout
	floor_level.visible = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	color_rect.visible = false
	Global.floor += 1
	floor_level.text = "floor " + str(Global.floor)
	print(Global.floor)
func generate_level():
	room_ = floor_sizes.pick_random()
	var walker = Walker.new(Vector2(20,16),borders)
	var map = walker.walk(room_[0])
	var exit = exitDoor.instantiate()
	add_child(exit)
	exit.leaving_level.connect(on_leaving_level)
	exit.reload.connect(reload_level)
	exit.position = walker.get_end_room().position * 64
	var enem_rooms = walker.rooms
	enem_rooms.pop_front()
	for room in enem_rooms:
		if room == walker.get_end_room():
			print("last room")
			enem_rooms.erase(room)
	for i in range(1,6):
		if randi_range(0 , room_[1] )<= 4:
			var room = enem_rooms.pick_random()
			enem_rooms.erase(room)
			var enem = Enemy.instantiate()
			enemies.add_child(enem)
			enem.position = room["position"] * 64
			Global.enemy_pool.append(enem)
	if enemies.get_child_count() == 0 :
		var room = enem_rooms.pick_random()
		enem_rooms.erase(room)
		var enem = Enemy.instantiate()
		enemies.add_child(enem)
		enem.position = room["position"] * 64
	var player = Player.instantiate()
	add_child(player)
	player.position = map.front() * 64
	#move_child(player, 0)
	walker.queue_free()
	var cells = []
	for location in map:
		var veci = Vector2i(location.x,location.y)
		tile_map.set_cell(0,veci,0,Vector2i(0,4),0)
		cells.append(veci)
	tile_map.set_cells_terrain_connect(0,cells,0,-1)
	enemy_count.text = "Ghosts Found 0/" + str(enemies.get_child_count())
	nav_region.bake_navigation_polygon()
	 
func on_leaving_level():
	animation_player.play("fade_in")
	await animation_player.animation_finished
	if passable:
		get_tree().reload_current_scene()

func reload_level():
	get_tree().reload_current_scene()

func _on_score_manager_exit():
	passable = true
