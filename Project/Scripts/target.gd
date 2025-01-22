extends Node2D
var gridPos: Vector2i

func _ready():
	gridPos = position/64
	position = gridPos*64
