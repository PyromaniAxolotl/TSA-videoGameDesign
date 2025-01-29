extends Node

func changeScene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)

func quit():
	SaveManager.writeData()
	get_tree().quit()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		SaveManager.writeData()
		get_tree().quit()

func _ready():
	get_tree().set_auto_accept_quit(false)
