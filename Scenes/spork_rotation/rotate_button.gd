extends Button

func _ready() -> void:
	pressed.connect(_rotate)

func _rotate()->void:
	RotationManager.rotate_spork(1)
