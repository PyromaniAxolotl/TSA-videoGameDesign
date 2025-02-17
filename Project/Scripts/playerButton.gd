extends TextureButton

@onready var number = int(str(name))
var controlList: Array = ["Up","Down","Left","Right","Grab","Use","Go"]
var inputList: Array = [
	[KEY_W,KEY_S,KEY_A,KEY_D,KEY_H,KEY_J,KEY_K],
	[KEY_UP,KEY_DOWN,KEY_LEFT,KEY_RIGHT,KEY_A,KEY_S,KEY_D],
	[KEY_UP,KEY_A,KEY_K,KEY_L,KEY_DOWN,KEY_S,KEY_J],
	[KEY_UP,KEY_DOWN,KEY_1,KEY_MINUS,KEY_2,KEY_0,KEY_SPACE]
	]

func key(targetKey):
	var key = InputEventKey.new()
	key.physical_keycode = targetKey
	return key

func setInput(action: String, key):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action,key(key))

func _pressed():
	for i in range(7):
		setInput(controlList[i],inputList[number-1][i])
	SaveManager.inputMap = number
	$"../..".visible=false
	$"../../../Menu".visible=true
