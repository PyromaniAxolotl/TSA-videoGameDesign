class_name Pickupable extends Node2D

@export var gridPos: Vector2i
@export var id: int

func startUseItem():
	if $".."==%Player/Sprite2D:
		$"../../..".useItem.emit(id)

func useItem(thingything):
	pass

func tryPickup():
	if $".."==%Player/Sprite2D:
		gridPos=$"../..".gridPos
		reparent($"../../..")
		pickupTransform(0)
	elif gridPos == %Player.gridPos:
		reparent(%Player/Sprite2D)
		pickupTransform(1)

func pickupTransform(hold: bool):
	if hold:
		$Sprite2D.scale=Vector2(2,2)
	else:
		$Sprite2D.scale=Vector2(3.5,3.5)

func _ready():
	gridPos = position/64
	position = gridPos*64
