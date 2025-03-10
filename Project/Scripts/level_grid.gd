extends GridContainer

@export var world: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveManager.numberOfLevels>(world-1)*10: #Prevents crashes during development
		for i in range(min(SaveManager.numberOfLevels-1-((world-1)*10),9)):
			add_child(get_node("levelSelectTemplate1").duplicate(),true)
		var children = get_children()
		for i in range(len(children)):
			children[i].level = i+(world*10)-9
			children[i].create()
