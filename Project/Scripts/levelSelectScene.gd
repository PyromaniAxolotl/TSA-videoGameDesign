extends Control

var completionCriteria = [
	[11,8.0]
]

func _ready():
	while len(completionCriteria)<len(SaveManager.levelData):
		completionCriteria.append([0,0.0])
