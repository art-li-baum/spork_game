extends MeshInstance3D
class_name SporkRotator

var _spork_spin : Vector3 = Vector3.UP
var _spin_speed : float = 0.1
var spork_index : int = 0
@export var sporks : Array[Node3D] 



func _ready() -> void:
	RotationManager.spork_rotate.connect(rotate_spork)
	ProgressManager.new_spork.connect(swapsporks)
	pass

func rotate_spork(delta:float)-> void:
	
	var spin = log(delta) + ProgressManager._spork_level 

	
	global_rotate(_spork_spin,deg_to_rad(spin))
	
func swapsporks(i: int):
	
	if i < sporks.size():
		sporks[spork_index].visible = false
		sporks[i].visible = true
		spork_index = i


	

#func vector_along_axis(vector : Vector3, axis: Vector3)->Vector3:
#	#subtract the normalized vector from the axis
#	var difference = norm_vector - axis	
	#get the difference of the magnitudes
	#var portion = vector.length_squared() - difference.le
