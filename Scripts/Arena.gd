extends TileMap

@export var side: int = 9
@export var selection_layer = 1

var aStar: AStarGrid2D

func get_size () -> Vector2i:
	return Vector2i(side, side)

func clear_selection ():
	self.clear_layer(selection_layer)

func select (tile: Vector2i):
	self.set_cell(selection_layer, tile, 1, Vector2i.ZERO)

func find_path (start: Vector2i, end: Vector2i) -> Array[Vector2i]:
		return aStar.get_id_path(start, end)

func is_out_of_bounds(tile: Vector2i) -> bool:
	return not is_tile_navigable(tile)
	return tile != tile.clamp(Vector2i.ZERO, Vector2i(side, side))
	return self.get_cell_tile_data(0, tile) == null

func is_tile_navigable (tile: Vector2i) -> bool:
	var tile_data = self.get_cell_tile_data(0, tile)
	if tile_data == null:
		return false
		
	return tile_data.get_navigation_polygon(0) != null

# Called when the node enters the scene tree for the first time.
func _ready():
	aStar = AStarGrid2D.new()
	aStar.region = self.get_used_rect()
	aStar.cell_size = Vector2(1, 1)
	aStar.update()
	for cell in self.get_used_cells(0):
		var cell_data: TileData = self.get_cell_tile_data(0, cell)
		if cell_data.get_navigation_polygon(0) == null:
			aStar.set_point_solid(cell)
	print(aStar.region)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
