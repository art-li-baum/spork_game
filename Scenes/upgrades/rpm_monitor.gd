extends Label

func _process(delta: float) -> void:
	if(RotationManager._spin_velocity <= 0):
		visible = false
		return
	else:
		visible = true
		text = "RPS: %.2f" % (RotationManager._spin_velocity) 
