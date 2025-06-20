extends Node

var _spork_level : int = 0

signal level_up(int)
signal unlock_clock()
signal unlock_title()

signal aesthetic(int)

signal new_spork(int)

signal finale()


func _process(delta: float) -> void:
	match(_spork_level):
		4: 
			if(RotationManager.total_spork_y_rotations >= 50):
				add_spork_level()


func add_spork_level()->int:
	_spork_level += 1
	
	level_up.emit(_spork_level)
	
	return _spork_level
