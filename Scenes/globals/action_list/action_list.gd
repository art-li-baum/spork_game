extends Node

var _action_list : Array[Action]

var dt : float = 1

var active_channels : CHANNEL = 1

enum CHANNEL{
	A = 1,
	B = 2,
	C = 4,
	D = 8,
	E = 16,
	F = 32,
}


func _process(delta: float) -> void:
	DebugDraw2D.debug_enabled = false
	var i : int = 0
	var size : int = _action_list.size()
	
	DebugDraw2D.clear_texts()
	
	DebugDraw2D.begin_text_group("Actions")
	
	while (i < size):
		var action =	_action_list[i]
		
		DebugDraw2D.set_text("%d " % i + action.a_print() )
		
		if(!is_active_channel(action)): return
		
		if(action.is_alive):
			if(action.delay > 0):
				#tick down delay
				action.delay -= delta * dt
			elif (action.delay > -5):
				action.enter()
			else:
				action.update(delta * dt)
		else:
			_action_list.erase(action)
			size -= 1
			continue
			
		i += 1
			
	DebugDraw2D.end_text_group()
	
func add_action(action : Action) -> void:
	_action_list.push_back(action)
	
func is_active_channel(action : Action) -> bool:
	return  active_channels & action.channel 
	
func activate_channel(c : CHANNEL):
	active_channels |= c

func deactivate_channel(c : CHANNEL):
	active_channels &= ~c


class Action:
	
	var is_alive : bool = true
	
	var channel : CHANNEL
	var delay : float
	
	func _init(d :float = -10, c :CHANNEL = CHANNEL.A) -> void:
		delay = d
		channel = c
	
	func enter()->void:
		#denotes the action has stared
		delay = -10
		pass
	func update(delta: float)->void:
		pass
	func exit()->void:
		is_alive = false
		pass
	
	func a_print()-> String:
		return "Action"
		pass

class Move3DAction extends Action:
	
	var start_pos : Vector3
	var end_pos : Vector3
	
	var duration : float
	
	var object : Node3D
	
	var _current_time : float = 0

	
	func _init(target: Node3D,  start:Vector3, end:Vector3, time: float,d:float = -10, c: CHANNEL = CHANNEL.A)-> void:
		super(d,c)
		start_pos = start
		end_pos = end
		duration = time
		object = target
		
	func update(delta: float):
		super(delta)
		
		if(_current_time > duration):
			exit()
			return
		
		object.global_position = start_pos.lerp(end_pos,_current_time/duration)
	
		_current_time += delta
	
	func a_print()-> String:
		return "Move Action : %.2f / %.2f" % [_current_time, duration]
