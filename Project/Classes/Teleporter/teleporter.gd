@icon("res://Classes/Teleporter/Teleporter.png")
class_name teleporter extends Pickupable

@export var color: Color
@onready var partner = get_node(NodePath("../"+name.substr(0,len(name)-1)+str(int(name.substr(len(name)-1))+(1+(-2*((int(name.substr(len(name)-1))%2)))))))

func useItem():
	var player = %Player
	var tempPosition = partner.position
	$"/root/level".tryPickup.emit()
	player.position = tempPosition
	player.gridPos = partner.gridPos


func _ready():
	$Sprite2D.material.set_shader_parameter("new_color",color)
	get_node(NodePath(str(partner.get_path())+"/Sprite2D")).material.set_shader_parameter("new_color",color)
	gridPos = position/64
	position = gridPos*64
