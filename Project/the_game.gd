extends Node

var save_manager = preload("res://Preloads/saveManager.tscn")
var transition_manager = preload("res://Preloads/transitionManager.tscn")
var level_select = preload("res://level_select.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(level_select)
	add_child(save_manager)
	add_child(transition_manager)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
