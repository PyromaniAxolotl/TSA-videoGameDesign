extends AspectRatioContainer

var level: int

func _ready():
	var flowers: Array = [$flowerTurns,$flowerTime]
	var levelData = SaveManager.levelData[level]
	var completionCriteria = $"../..".completionCriteria[level]

	if levelData[0]:
		$flowerCompletion.visible = true
	for i in range(2):
		flowers[i].visible = not (levelData[i+1] > completionCriteria[i] or levelData[i+1]==0)
