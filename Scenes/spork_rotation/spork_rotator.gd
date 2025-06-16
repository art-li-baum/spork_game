extends MeshInstance3D
class_name SporkRotator

var _spork_spin : Vector3 = Vector3.UP
var _spin_speed : float = 0.1

func _ready() -> void:
	#RotationManager.spork_rotate.connect(rotate_spork)
	pass

func rotate_spork(axis:Vector3)-> void:
	global_rotate(axis,_spin_speed)


	

#func vector_along_axis(vector : Vector3, axis: Vector3)->Vector3:
#	#subtract the normalized vector from the axis
#	var difference = norm_vector - axis	
	#get the difference of the magnitudes
	#var portion = vector.length_squared() - difference.le
