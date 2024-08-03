extends TileMap
var map_rect = Rect2i()
var aStar = AStarGrid2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap_size = get_used_rect().end - get_used_rect().position
	map_rect = Rect2i(Vector2i.ZERO , tilemap_size)
	aStar.region = map_rect
	aStar.cell_size = get_tileset().tile_size
	aStar.default_compute_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	aStar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	aStar.update()
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords = Vector2i(i,j)
			var tile_data = get_cell_tile_data(0,coords)
			if tile_data && tile_data.get_custom_data('type') == "wall":
				aStar.set_point_solid(coords)

func is_point_walkable(position):
	var map_pos = local_to_map(position)
	if map_rect.has_point(map_pos) and not aStar.is_point_solid(map_pos):
		return true
	return false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
