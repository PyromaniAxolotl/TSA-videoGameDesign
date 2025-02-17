extends AspectRatioContainer
var level: int = 1

#Custom function, not "_ready"
func create():
	var flowers: Array = [$flowerTurns,$flowerTime]
	var levelData = SaveManager.levelData[level-1]
	var completionCriteria = $"../../..".completionCriteria[level-1]

	$TextureButton/MarginContainer/Label.text = str(level)
	$flowerCompletion.visible = levelData[0]
	for i in range(2):
		flowers[i].visible = not (levelData[i+1] > completionCriteria[i] or levelData[i+1]==-1)
