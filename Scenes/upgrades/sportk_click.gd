extends Button

func _ready() -> void:
	pressed.connect(on_click)

func on_click():
	RotationManager.rotate_spork(RotationManager.click_strength)
