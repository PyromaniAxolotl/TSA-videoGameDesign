extends AspectRatioContainer
var level: int = 1
func _ready():
	print(int(name.substr(len(name)-1)))
	level = int(name.substr(len(name)-1))
	var flowers: Array = [$flowerTurns,$flowerTime]
	var levelData = SaveManager.levelData[level-1]
	var completionCriteria = $"../..".completionCriteria[level-1]
	
	print(levelData)
	print(levelData[0])
	$flowerCompletion.visible = levelData[0]
	for i in range(2):
		flowers[i].visible = not (levelData[i+1] > completionCriteria[i] or levelData[i+1]==0)
