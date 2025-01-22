extends Sprite2D

var sinVar: float = 0
var hoverSpeed: float = 0.1
@export var direction: int = 0

func floatModulo(f1: float,f2: float):
	if f1>f2:
		return f1-f2
	return f1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var y = -sin(sinVar)
	offset.y = y
	sinVar = floatModulo(sinVar + hoverSpeed, 2*PI)
	frame = direction*4 + int(sinVar>0.5 and sinVar<4) + (int($"..".pollinated) * 2)

func _ready():
	direction = $"..".startDirection
