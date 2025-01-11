extends CharacterBody2D

const tileInaccessibility: Array = [[Vector2(0,0)],[Vector2(1,0),Vector2(0,1)],[Vector2(0,1)],[Vector2(-1,0),Vector2(0,1)],[Vector2(1,0)],[Vector2(1,1)],[Vector2(-1,0)],[Vector2(1,0),Vector2(0,-1)],[Vector2(0,-1)],[Vector2(-1,0),Vector2(0,-1)]]
#A complete list of tile innaccessibility, the walkability of a tile will be used as the index in the list, so we know what not to do.
var moveFrame: int = 0
var actionable: bool = 1
var walkability: int = 0
@export var playerPos: Vector2i

func getAccess(vector:Vector2, array:Array) -> bool:
	for i in array:
		if i==vector:
			return true
	return false

func startMovement(axis:Vector2i):
	print("movement started")
	if $".."/TileMapLayer.get_cell_tile_data(Vector2i(playerPos.x+axis.x,playerPos.y+axis.y))!=null:
		walkability = $".."/TileMapLayer.get_cell_tile_data(Vector2i(playerPos.x+axis.x,playerPos.y+axis.y)).get_custom_data("walkability")
		print(axis," ",tileInaccessibility[walkability])
		if not (getAccess(axis,tileInaccessibility[walkability]) or tileInaccessibility[walkability][0]==Vector2(0,0)): #Not inaccessible = accessible
			moveFrame = 1
			playerPos=Vector2i(playerPos.x+axis.x,playerPos.y+axis.y)
			set_velocity(Vector2((1.0/3) * axis.x , (1.0/3) * axis.y))
			print(axis)
			return
	$"..".action+=1
	$"..".handleActions()

func move():
	set_position(Vector2(get_position().x+get_velocity().x,get_position().y+get_velocity().y))
	if 0<moveFrame and moveFrame<6:
		set_velocity(Vector2(get_velocity().x + sign(get_velocity().x)*1.7, get_velocity().y + sign(get_velocity().y)*1.7))
	elif 7<moveFrame and moveFrame<12:
		set_velocity(Vector2(get_velocity().x - sign(get_velocity().x)*1.7, get_velocity().y - sign(get_velocity().y)*1.7))
	elif moveFrame>11:
		set_position(Vector2(playerPos.x*64,playerPos.y*64))
		set_velocity(Vector2(0,0))
		moveFrame=0
		$"..".action+=1
		$"..".handleActions()
		return
	if moveFrame>0:
		moveFrame+=1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	move()
