class_name Pickupable extends Node2D

@export var gridPos: Vector2i
@export var id: int

func startUseItem():
	if get_parent()==%Player:
		$"../..".useItem.emit(id)

func useItem(id: int = -1):
	pass

func tryPickup():
	if $".."==%Player:
		gridPos=get_parent().gridPos
		reparent($"../..")
		pickupTransform(0)
	elif gridPos == %Player.gridPos:
		reparent(%Player)
		pickupTransform(1)

func pickupTransform(hold: bool):
	if hold:
		$Sprite2D.scale=Vector2(2,2)
	else:
		$Sprite2D.scale=Vector2(3.5,3.5)

func _ready():
	position = gridPos*64
