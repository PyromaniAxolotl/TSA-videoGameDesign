extends Control

var worldRequirements: Array = [15,30]
var completionCriteria = [
	[14,15.0],
	[18,16.0],
	[26,27.0],
	[15,13.0],
	[32,29.0],
	[15,14.0],
	[26,24.0],
	[22,17.0],
	[21,16.0],
	[36,32.0],
	[29,13.0],
	[25,25.0],
	[35,45.0],
	[100,100.0],
	[100,100.0],
	[100,100.0],
	[100,100.0],
	[100,100.0],
	[100,100.0],
	[100,100.0]
]

func _ready(): #Prevents crash during development of levels, so you can play without completion criteria
	while len(completionCriteria)<len(SaveManager.levelData):
		completionCriteria.append([0,0.0])
