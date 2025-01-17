extends Node2D

const tileInaccessibility: Array = [[Vector2i(0,0)],[Vector2i(1,0),Vector2i(0,1)],[Vector2i(0,1)],[Vector2i(-1,0),Vector2i(0,1)],[Vector2i(1,0)],[Vector2i(1,1)],[Vector2i(-1,0)],[Vector2i(1,0),Vector2i(0,-1)],[Vector2i(0,-1)],[Vector2i(-1,0),Vector2i(0,-1)]]
#A complete list of tile innaccessibility, the walkability value of a tile will be used as the index in the list.
var moveFrame: int = 0
var actionable: bool = 1
var walkability: int = 0
var pollinated: bool = 0
var velocity: Vector2
@export var gridPos: Vector2i

func startMovement(moveVector:Vector2i):
	if %TileMapLayer.get_cell_tile_data(gridPos+moveVector)!=null:
		walkability = %TileMapLayer.get_cell_tile_data(gridPos+moveVector).get_custom_data("walkability")
		if not (moveVector in tileInaccessibility[walkability] or tileInaccessibility[walkability][0]==Vector2i(0,0)): #Not inaccessible = accessible
			moveFrame = 1
			gridPos=gridPos+moveVector
			velocity = (Vector2((1.0/3) * moveVector.x , (1.0/3) * moveVector.y))
			return
	$"..".action+=1
	$"..".handleActions()

func move():
	position = (velocity + position)
	if 0<moveFrame and moveFrame<6:
		velocity = (Vector2(velocity.x + sign(velocity.x)*1.7, velocity.y + sign(velocity.y)*1.7))
	elif 7<moveFrame and moveFrame<12:
		velocity = (Vector2(velocity.x - sign(velocity.x)*1.7, velocity.y - sign(velocity.y)*1.7))
	elif moveFrame>11:
		position = (gridPos*64)
		if gridPos == $".."/Flower.gridPos:
			pollinated = true
		velocity = (Vector2(0,0))
		moveFrame=0
		$"..".action+=1
		$"..".handleActions()
		return
	if moveFrame>0:
		moveFrame+=1

func _ready() -> void:
	position = gridPos * 64

func _process(delta: float) -> void:
	move()
