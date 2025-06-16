extends RichTextLabel

func _process(delta: float) -> void:
	text = "spork rotations : " + RotationManager.total_rotation_y_string()
