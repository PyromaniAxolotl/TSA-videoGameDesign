extends Button


# Called when the node enters the scene tree for the first time.
func _pressed():
	DirAccess.open("user://").remove("saveData.dat")
	get_tree().auto_accept_quit=true
	get_tree().quit()
