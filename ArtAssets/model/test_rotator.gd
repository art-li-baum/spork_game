extends Node3D
var speed: float = .5

func _process(delta: float) -> void:
	global_rotate(Vector3.UP,delta*speed)
