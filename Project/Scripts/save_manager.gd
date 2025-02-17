extends Node

var levelData: Array
var inputMap: int = 0
@export var numberOfLevels: int = 0

func loadData(initial: bool = 0):
	var saveData = FileAccess.open("user://saveData.dat",FileAccess.READ)
	if initial:
		for k in range(numberOfLevels):
			levelData.append([false,-1,-1])
	inputMap = int(saveData.get_line())
	for i in range(numberOfLevels):
		levelData[i] = Array(saveData.get_line().split(" "))
		levelData[i][0] = levelData[i][0]=="true" #Complete
		levelData[i][1] = int(levelData[i][1]) #Turns
		levelData[i][2] = float(levelData[i][2]) #Time

func writeData():
	$Label.save()
	var saveData = FileAccess.open("user://saveData.dat",FileAccess.WRITE)
	saveData.store_line(str(inputMap))
	for i in levelData.duplicate(true):
		for k in range(3):
			i[k]=str(i[k])
		saveData.store_line(" ".join(i))

func _ready() -> void:
	for i in range(numberOfLevels): #Creates an uncompleted level for each level.
			levelData.append([false, -1, -1.0])
	#if not FileAccess.file_exists("user://saveData.dat"):
		#var saveData = FileAccess.open("user://saveData.dat", FileAccess.WRITE)
		#saveData.store_line("0")
		#for i in range(numberOfLevels): #Creates an uncompleted level for each level.
			#levelData.append([false, -1, -1.0])
			#saveData.store_line("false -1 -1")
	#else:
		#loadData(true)
	#
