extends Node2D

const tileInaccessibility: Array = [
[Vector2i(-1,0),Vector2i(0,-1),Vector2i(1,0),Vector2i(0,1)],
[Vector2i(1,0),Vector2i(0,1)],
[Vector2i(0,1)],
[Vector2i(-1,0),Vector2i(0,1)],
[Vector2i(1,0)],
[Vector2i(1,1)],
[Vector2i(-1,0)],
[Vector2i(1,0),Vector2i(0,-1)],
[Vector2i(0,-1)],
[Vector2i(-1,0),Vector2i(0,-1)],
[Vector2i(0,-1),Vector2i(1,0),Vector2i(0,1)],
[Vector2i(-1,0),Vector2i(0,-1),Vector2i(0,1)],
[Vector2i(-1,0),Vector2i(1,0),Vector2i(0,1)],
[Vector2i(-1,0),Vector2i(0,-1),Vector2i(1,0)],
[Vector2i(0,-1),Vector2i(0,1)],
[Vector2i(-1,0),Vector2i(1,0)],
]
#A complete list of tile innaccessibility, the walkability value of a tile will be used as the index in the list. Originally was more spatially efficient, but at this this stage idek
var actionable: bool = 1
var walkability: int = 0
var pollinated: bool = 0
var gridPos: Vector2i

@export var startDirection: int = 1

func startMovement(moveVector:Vector2i):
	if %TileMapLayer.get_cell_tile_data(gridPos+moveVector)!=null:
		walkability = %TileMapLayer.get_cell_tile_data(gridPos+moveVector).get_custom_data("walkability")
		if not (moveVector in tileInaccessibility[walkability] or tileInaccessibility[walkability][0]==Vector2i(0,0)): #Not inaccessible = accessible
			$AnimationPlayer.play(["up","down","left","right"][[Vector2i(0,-1),Vector2i(0,1),Vector2i(-1,0),Vector2i(1,0)].find(moveVector)])
			gridPos+=moveVector
			return
	$"..".action+=1
	$"..".handleActions()

func finishMovement(_animName: String):
	if gridPos == $".."/Flower.gridPos:
		pollinated = true
	if gridPos == $".."/Hive.gridPos and pollinated:
		$"..".finishLevel()
		return
	$Sprite2D.position=Vector2(0,0)
	position = gridPos*64
	$"..".action+=1
	$"..".handleActions()

func _ready() -> void:
	gridPos = position/64
	position = gridPos*64
	$AnimationPlayer.animation_finished.connect(finishMovement)

func _process(_delta: float) -> void:
	pass
