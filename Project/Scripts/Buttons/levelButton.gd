extends TextureButton


# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	TransitionManager.changeScene(load("res://Levels/level"+str($"..".level)+".tscn"))
