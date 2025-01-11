extends Node

var inputArray: Array = []
var exclusiveInputArray: Array = []
const controlList: Array = ["Up","Down","Left","Right","Grab","Use"] #An array of player controls for my sanity
const movementAxes: Array = [Vector2i(0,-1),Vector2i(0,1),Vector2i(-1,0),Vector2i(1,0)]
var action: int = 0 #Keeps track of what action is being used during a turn

func correctInputs():
	for i in range(len(inputArray)):
		if not Input.is_action_pressed(inputArray[i]): #Assigns released inputs to 0's
			inputArray[i]=0
	while inputArray.find(0)!= -1: #Removes those 0's from the array
		var index: int = inputArray.find(0)
		inputArray.pop_at(index)
		exclusiveInputArray.pop_at(index)

	if len(inputArray)<3:
		#I miss generators
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
	$Bee.actionable=false
	if action>len(inputArray)-1:
		action=0
		$Bee.actionable=true
		return
	if controlList.find(inputArray[action])<=4: #Checks for a movement action
		$Bee.startMovement([Vector2(0,-1),Vector2(0,1),Vector2(-1,0),Vector2(1,0)][controlList.find(inputArray[action])]) #Runs the move function with one of four axes

# Called when the node enters the scene tree for the first time (good for duplicating nodes with script).
func _ready() -> void:
	$Bee.position = Vector2(64*$Bee.playerPos.x,64*$Bee.playerPos.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Bee.actionable:
		correctInputs()
		if Input.is_action_just_pressed("Go") and $Bee.actionable:
			handleActions()
	displayInputs()
	
