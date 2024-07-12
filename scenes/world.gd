extends  CanvasModulate

var borders = Rect2(1 , 1 , 40 , 24 )
const Player = preload("res://scenes/player.tscn")
@onready var tile_map = $TileMap
const exitDoor = preload("res://scenes/exit.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_level()


func generate_level():
	var walker = Walker.new(Vector2(20,16),borders)
	var map = walker.walk(500)
	var exit = exitDoor.instantiate()
	add_child(exit)
	exit.position = walker.get_end_room().position * 64
	var player = Player.instantiate()
	add_child(player)
	player.position = map.front()*64
	#move_child(player, 0)
	walker.queue_free()
	var cells = []
	for location in map:
		var veci = Vector2i(location.x,location.y)
		tile_map.set_cell(0,veci,0,Vector2i(0,4),0)
		cells.append(veci)
	tile_map.set_cells_terrain_connect(0,cells,0,-1)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
