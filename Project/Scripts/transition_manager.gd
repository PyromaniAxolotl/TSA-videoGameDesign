extends Node

func changeScene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)
