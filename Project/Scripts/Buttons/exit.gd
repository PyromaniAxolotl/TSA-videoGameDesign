extends TextureButton


# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	SaveManager.writeData()
	get_tree().quit()
