@icon("res://Classes/Teleporter/Teleporter.png")
class_name teleporter extends Pickupable

@onready var partner = get_node(NodePath("../"+name.substr(0,len(name)-1)+str(int(name.substr(len(name)-1))+(1+(-2*((int(name.substr(len(name)-1))%2)))))))
@onready var color = material.get_shader_parameter("new_color")
@export var syncColors: bool = 1

func useItem():
	var player = %Player
	var tempPosition = partner.position
	$"/root/level".tryPickup.emit()
	player.position = tempPosition
	player.gridPos = partner.gridPos
	SoundManager.playSound(SoundManager.teleport)


func _ready():
	if syncColors: partner.material.set_shader_parameter("new_color",color)
	gridPos = position/64
	position = gridPos*64
