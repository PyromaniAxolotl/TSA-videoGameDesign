extends Node2D

@onready var inputMap = SaveManager.inputMap

func _ready():
	if inputMap:
		get_node(NodePath("TextureRect/HBoxContainer/"+str(inputMap)))._pressed()
	$TextureRect.visible = not inputMap
	$Menu.visible = inputMap
