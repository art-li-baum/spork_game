extends AnimatedSprite3D

var spin :float = 0

func _ready() -> void:
	RotationManager.spork_rotate.connect(rotate_spork)
	ProgressManager.new_spork.connect(upgrade)
	#TEST ActionList.add_action(SporkAction.SporkTestMove.new(self))

func upgrade(level:int):
	visible = false

func rotate_spork(delta:float)->void:
	spin += delta * 6 
	if(spin >= 1):
		spin = 0
		frame = (frame + 1 ) % 6
