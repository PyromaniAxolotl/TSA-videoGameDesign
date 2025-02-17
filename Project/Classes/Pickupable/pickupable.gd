class_name Pickupable extends Node2D

@export_range(0,2) var id: int
var gridPos: Vector2i

func useItem():
	pass

func tryPickup():
	if $".."==%Player/Sprite2D:
		gridPos=%Player.gridPos
		reparent($"../../..")
		position=%Player.position
		pickupTransform(0)
	elif gridPos == %Player.gridPos:
		reparent(%Player/Sprite2D)
		pickupTransform(1)

func pickupTransform(hold: bool):
	if hold:
		$Sprite2D.scale=Vector2(2,2)
	else:
		$Sprite2D.scale=Vector2(4,4)

func _ready():
	gridPos = position/64
	position = gridPos*64
