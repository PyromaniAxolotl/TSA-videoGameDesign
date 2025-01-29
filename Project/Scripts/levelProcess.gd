extends Node

const controlList: Array = ["Up","Down","Left","Right","Grab","Use"] #An array of player controls for my sanity

@export var level: int
var time: float
var turns: int = 0
var inputArray: Array
var tempInputArray: Array
var exclusiveInputArray: Array
var action: int = 0 #Keeps track of what action is being used during a turn
var turnQueue: int = 0

signal tryPickup

func correctInputs():
	for i in range(len(inputArray)):
		if not Input.is_action_pressed(inputArray[i]): #Assigns released inputs to 0's
			inputArray[i]=0
	while inputArray.find(0)!= -1: #Removes those 0's from the array
		var index: int = inputArray.find(0)
		inputArray.pop_at(index)
		exclusiveInputArray.pop_at(index)

	if len(inputArray)<3:
		for i in controlList: if (not i in inputArray) and (not i in exclusiveInputArray): #Runs through every input that wasn't pressed last frame, ignoring exclusives
			if Input.is_action_just_pressed(i) and len(inputArray)<3: #Adds pressed inputs to inputArray
				inputArray.append(i)
				exclusiveInputArray.append(controlList[controlList.find(i)+(1+(-2*(controlList.find(i)%2)))]) #Adds the exlusive of the input to the list

func displayInputs():
	for i in range(3):
		if len(inputArray)>i:
			[$Controls/left,$Controls/middle,$Controls/right][i].frame = controlList.find(inputArray[i])
			[$Controls/left,$Controls/middle,$Controls/right][i].visible = true
		else:
			[$Controls/left,$Controls/middle,$Controls/right][i].visible = false

func handleActions():
	%Player.actionable=false
	if action==0: #tempInputArray allows players to prepare actions while the turn is taking place.
		tempInputArray = inputArray.duplicate()
	if action>=len(tempInputArray):
		action=0
		%Player.actionable=true
		return
	var inputValue = controlList.find(tempInputArray[action])
	if inputValue<=3: #Checks for a movement action
		%Player.startMovement([Vector2(0,-1),Vector2(0,1),Vector2(-1,0),Vector2(1,0)][inputValue]) #Runs the move function with one of four axes
	elif inputValue==4:
		action+=1
		tryPickup.emit()
		handleActions()
	elif inputValue==5:
		action+=1
		if %Player/Sprite2D.get_child_count()==1:
			%Player/Sprite2D.get_children()[0].useItem()
		handleActions()

func finishLevel():
	SaveManager.levelData[level]=[true,turns,time]
	SaveManager.writeData()
	TransitionManager.changeScene(load("res://level_select.tscn"))

# Called when the node enters the scene tree for the first time (good for duplicating nodes with script).
func _ready() -> void:
	level-=1
	for node in get_tree().get_nodes_in_group("Pickupables"):
		tryPickup.connect(node.tryPickup)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time>0:
		time+=delta
		$Timer.text = ":".join(str(time).pad_decimals(2).split("."))
	$Turns.text = str(turns)
	correctInputs()
	if Input.is_action_just_pressed("Go"):
		turnQueue += 1
		if time==0:
			time+=delta
	if turnQueue and %Player.actionable:
		handleActions()
		turns+=1
		turnQueue-=1
	if Input.is_action_just_pressed("Reset"): #Resets level to initial state.
		get_tree().reload_current_scene()
	displayInputs()
