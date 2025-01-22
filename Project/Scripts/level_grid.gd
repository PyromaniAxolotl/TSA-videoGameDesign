extends GridContainer

@export var world: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(SaveManager.numberOfLevels-1):
		add_child(get_node("levelSelectTemplate1").duplicate())
	var children = get_children()
	for i in range(len(children)):
		children[i].level=i+1
		get_node(NodePath(str(children[i].get_path())+"/TextureButton/MarginContainer/Label")).text = str(((world-1)*15)+children[i].level)
