extends Node

var targetScene: PackedScene
var targetWorld: int = 0

func changeScene(scene: PackedScene, world: int = 0):
	$BeeTransition/AnimationPlayer.animation_finished.connect(_onAnimationFinished_changeScene)
	$BeeTransition.visible = true
	targetScene = scene
	targetWorld = world
	$BeeTransition/AnimationPlayer.play("in")
	
func reloadScene():
	$BeeTransition/AnimationPlayer.animation_finished.connect(_onAnimationFinished_reloadScene)
	$BeeTransition.visible = true
	$BeeTransition/AnimationPlayer.play("in")
	

func _onAnimationFinished_reloadScene(animation: StringName):
	if animation == "in":
		get_tree().reload_current_scene()
		$BeeTransition/AnimationPlayer.play("out")
	elif animation == "out":
		$BeeTransition.visible=false

func _onAnimationFinished_changeScene(animation: StringName):
	if animation == "in":
		get_tree().change_scene_to_packed(targetScene)
		$BeeTransition/AnimationPlayer.play("out")
	elif animation == "out":
		$BeeTransition.visible=false

func quit():
	SaveManager.writeData()
	get_tree().quit()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		SaveManager.writeData()
		get_tree().quit()

func _ready():
	get_tree().set_auto_accept_quit(false)
