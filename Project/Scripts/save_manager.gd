extends Node

var levelData: Array
@export var numberOfLevels: int = 0

func loadData(initial: bool = 0):
	var saveData = FileAccess.open("user://saveData.dat",FileAccess.READ)
	
	var i = 0
	if initial:
		for k in range(numberOfLevels):
			levelData.append([0,0,0])
	while saveData.get_position() < saveData.get_length():
		levelData[i] = Array(saveData.get_line().split(" "))
		levelData[i][0] = levelData[i][0]=="true" #Complete
		levelData[i][1] = int(levelData[i][1]) #Turns
		levelData[i][2] = float(levelData[i][2]) #Time

func writeData():
	$Label.save()
	print(levelData)
	var saveData = FileAccess.open("user://saveData.dat",FileAccess.WRITE)
	for i in levelData.duplicate(true):
		for k in range(3):
			i[k]=str(i[k])
		saveData.store_line(" ".join(i))
	print(levelData)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	if not FileAccess.file_exists("user://saveData.dat"):
		var saveData = FileAccess.open("user://saveData.dat", FileAccess.WRITE)
		for i in range(len(DirAccess.get_files_at("res://Levels"))): #Creates an uncompleted level for each level.
			levelData.append([false, 0, 0.0])
			saveData.store_line("0 0 0")
	else:
		loadData(true)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		writeData()
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
