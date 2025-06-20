# Stores spork specific sequences

class_name SporkAction 


class SporkTestMove extends ActionList.Move3DAction:
	var rand : RandomNumberGenerator
	func _init(obj: Node3D) -> void:
		rand = RandomNumberGenerator.new()
		super(obj,obj.global_position,Vector3(rand.randf_range(-6.0,6),rand.randf_range(-2,2),-5),rand.randf_range(0.5,3.0))
		
	func exit():
		super()
		
		ActionList.add_action(SporkTestMove.new(object))
