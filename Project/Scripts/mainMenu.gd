extends Node2D

var world: int = 0
var flowers: int = 0
func changeWorld(direction: int):
	$menuElements/levelSelect/ui/worldSelectRight.visible = false
	$menuElements/levelSelect/ui/worldSelectLeft.visible = false
	world = clamp(world+direction,1,3)
	if direction==1:
		$AnimationPlayer.play("world"+str(world))
	elif direction==-1:
		$AnimationPlayer.play_backwards("world"+str(world+1))

func _onAnimationFinished(_animation: StringName = ""):
	if _animation == "toLevelSelect":
		world = 1
	$menuElements/levelSelect/ui/worldSelectRight.disabled = (flowers<15 and world==1) or (flowers<40 and world==2)
	$menuElements/levelSelect/ui/worldSelectRight.visible = world<3
	$menuElements/levelSelect/ui/worldSelectLeft.visible = world>1

func displayOptions():
	$menuElements/startMenu/TextureRect.visible = true
	$menuElements/startMenu/Menu.visible = false
	$menuElements/startMenu/Menu/Button/Sprite2D.frame = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.playMusic(SoundManager.buzzwords)
	
	var completionCriteria = $menuElements/levelSelect.completionCriteria
	var levelData = SaveManager.levelData
	for i in range(len(levelData)):
		flowers+=int(levelData[i][0])
		for k in range(2):
			if levelData[i][k+1] <= completionCriteria[i][k] and levelData[i][k+1] != -1:
				flowers+=1
	world = TransitionManager.targetWorld
	if world:
		position = Vector2((world-1)*-1152,-640)
		$menuElements/levelSelect/ui.position = Vector2((world-1)*1152,0)
		_onAnimationFinished()
		TransitionManager.targetWorld = 0
	
	$AnimationPlayer.animation_finished.connect(_onAnimationFinished)
	
	$menuElements/levelSelect/ui/worldSelectRight.pressed.connect(changeWorld.bind(1))
	$menuElements/levelSelect/ui/worldSelectLeft.pressed.connect(changeWorld.bind(-1))
	$menuElements/startMenu/Menu/Quit.pressed.connect(TransitionManager.quit)
	$menuElements/startMenu/Menu/Options.pressed.connect(displayOptions)
	$menuElements/startMenu/Menu/Start.pressed.connect($AnimationPlayer.play.bind("toLevelSelect"))
	$menuElements/levelSelect/ui/TextureButton.pressed.connect(TransitionManager.reloadScene)
