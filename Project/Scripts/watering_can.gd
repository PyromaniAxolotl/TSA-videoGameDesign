extends Pickupable

signal water

func useItem():
	SoundManager.playSound(SoundManager.water)
	water.emit()

func _ready():
	gridPos = position/64
	position = gridPos*64
	for node in get_tree().get_nodes_in_group("Pickupables"):
		if node.name.begins_with("Seed"):
			water.connect(node.water)
