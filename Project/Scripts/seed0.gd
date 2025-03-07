extends Pickupable

var dirs = [Vector2i(0,0),Vector2i(1,0),Vector2i(0,1),Vector2i(-1,0),Vector2i(0,-1)]

func water():
	var dirIndex: int = dirs.find(gridPos-%Player.gridPos)
	if dirIndex != -1 and %TileMapLayer.get_cell_tile_data(gridPos+dirs[dirIndex]) != null:
		%TileMapLayer.set_cell(gridPos+dirs[dirIndex],1,Vector2i(1,9))
		SoundManager.playSound(SoundManager.seedGrowth)
		queue_free()
