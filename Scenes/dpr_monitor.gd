extends Label

func _ready() -> void:
	visible = false
	ProgressManager.unlock_clock.connect(unlock)

func _process(delta: float) -> void:
	text = "dpr %.2f" % (1.0/DopamineManager.dop_rot_ration)

func unlock():
	visible = true
