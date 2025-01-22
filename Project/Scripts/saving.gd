extends Label

var timer: float = 0

func save():
	visible = true
	timer = 0.01
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer>0:
		timer+=delta
	if timer>3:
		timer = 0
		visible = false
