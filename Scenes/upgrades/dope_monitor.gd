extends Label

func _ready() -> void:
	visible = false
	ProgressManager.level_up.connect(unlock)
	
	
func _process(delta: float) -> void:
	text = "dopamine %d / %d" % [DopamineManager.banked_dopamine,DopamineManager.dopamine_capacity]
	
func unlock(level : int):
	if(level == 5):
		visible = true
