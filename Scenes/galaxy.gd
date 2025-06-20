extends Sprite3D


func _ready() -> void:
	ProgressManager.finale.connect(unlock)

func unlock():
	visible = true
