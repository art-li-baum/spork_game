extends Label

func _process(delta: float) -> void:
	if(ProgressManager._spork_level < 3):
		visible = false
		return
	else:
		visible = true
		text = "Click Strength: %.2f" % (RotationManager.click_strength) 
