extends Pickupable

var dirs = [Vector2i(0,0),Vector2i(1,0),Vector2i(0,1),Vector2i(-1,0),Vector2i(0,-1)]

func useItem(id: int = -1):
	if id==0:
		var dirIndex: int = dirs.find(gridPos-%Player.gridPos)
		if dirIndex != -1 and %TileMapLayer.get_cell_tile_data(gridPos+dirs[dirIndex]) != null:
			%TileMapLayer.set_cell(gridPos+dirs[dirIndex],1,Vector2i(3,2))
			queue_free()
