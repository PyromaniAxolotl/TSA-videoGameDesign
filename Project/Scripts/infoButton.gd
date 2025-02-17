extends Button

func _pressed():
	if $Sprite2D.frame == 0:
		$Sprite2D.frame = SaveManager.inputMap
	else:
		$Sprite2D.frame = 0
