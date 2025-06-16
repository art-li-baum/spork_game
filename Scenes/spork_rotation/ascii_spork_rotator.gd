extends AnimatedSprite3D


func _ready() -> void:
	RotationManager._spork_rotate.connect(rotate_spork)
	ActionList.add_action(SporkTestMove.new(self))

func rotate_spork(delta:float)->void:
	frame = (frame + int(delta)) % 6
