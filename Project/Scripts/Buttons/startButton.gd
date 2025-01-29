extends TextureButton


func _pressed():
	TransitionManager.changeScene(load("res://level_select.tscn"))
