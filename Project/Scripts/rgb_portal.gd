extends Node2D
@export var fluctuation: Vector4
@export var rate: float = 0
@onready var color: Color = material.get_shader_parameter("new_color")
var sinvar: float = 0.0

func modifyColor(color,attribute):
	if attribute!=0:
		return [color.s,color.v,color.a][attribute-1]+(sin(sinvar)*[fluctuation.x,fluctuation.y,fluctuation.z,fluctuation.w][attribute-1])
	return fmod(color.h+(sin(sinvar)*fluctuation.x),1)

func _process(delta):
	sinvar=fmod(sinvar+rate*delta,2*PI)
	material.set_shader_parameter("new_color", Color.from_hsv(modifyColor(color,0),modifyColor(color,1),modifyColor(color,2),modifyColor(color,3)))
