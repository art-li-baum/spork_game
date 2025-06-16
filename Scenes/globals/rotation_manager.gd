extends Node

var total_spork_y_rotations : float = 0
var _current_y_rotation :float = 0

signal _spork_rotate(float)
signal spork_add_spin()
signal spork_add_speed()

#TEST
var popup : bool = false

func _process(delta: float) -> void:
	#TEST
	if(total_spork_y_rotations > 10 and !popup):
		popup = true

func rotate_spork(delta:float)->void:
	if(_current_y_rotation + delta >= 6):
		_current_y_rotation = 0
		total_spork_y_rotations += 1
		
	_current_y_rotation += delta
	
	_spork_rotate.emit(delta)
	
	
func total_rotation_y_string()->String:
	var progress = "%d" % ((_current_y_rotation/6)*100)
	return "%d" % total_spork_y_rotations + "." + progress
	
