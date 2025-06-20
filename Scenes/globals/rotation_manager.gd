extends Node

var total_spork_y_rotations : float = 0
var _current_y_rotation :float = 0

var click_strength : float 

var _banked_rotation : float

var _spin_velocity : float = 0

var can_click :bool = false

var spork_teir : int = 0

signal spork_rotate(float)
signal speed_up(float)

func _process(delta: float) -> void:
	DebugDraw2D.debug_enabled = false
	
	#TEST
	#if(Input.is_key_pressed(KEY_0)):
		#click_strength = 50
	#if(Input.is_key_pressed(KEY_1)):
		#spork_add_speed(100)
	
	if(_spin_velocity > 0):
		rotate_spork(_spin_velocity*delta)
	

func rotate_spork(delta:float)->void:
	
	_current_y_rotation += delta 
	
	if(_current_y_rotation >= 1):
		var f = int(_current_y_rotation)
		total_spork_y_rotations += f
		_banked_rotation += f
		_current_y_rotation -= f
		
	match(spork_teir):
		0: if(total_spork_y_rotations >= 1000):
				ProgressManager.new_spork.emit(spork_teir)
				spork_teir += 1
		1: if(total_spork_y_rotations >= 10000):
				ProgressManager.new_spork.emit(spork_teir)
				spork_teir += 1
		2: if(total_spork_y_rotations >= 100000):
				ProgressManager.new_spork.emit(spork_teir)
				spork_teir += 1
		3: if(total_spork_y_rotations >= 250000):
				ProgressManager.new_spork.emit(spork_teir)
				spork_teir += 1
		4: if(total_spork_y_rotations >= 450000):
				ProgressManager.new_spork.emit(spork_teir)
				spork_teir += 1
		5: if(total_spork_y_rotations >= 800000):
				ProgressManager.new_spork.emit(spork_teir)
				spork_teir += 1
				
	spork_rotate.emit(delta)
	
func has_enough(cost: int)->bool:
	return cost <= _banked_rotation
	
func spend_rotation(cost: int):
	if(has_enough(cost)):
		_banked_rotation -= cost

func spork_add_speed(add:float):
	#might wanna cap this, idk
	_spin_velocity += add
	speed_up.emit(add)


func total_rotation_y_string()->String:
	var progress = "%d" % ((_current_y_rotation)*100)
	return "%d" % _banked_rotation + "." + progress
	
