extends Node2D
@export var gridPos: Vector2i

func _ready():
	position = gridPos*64
