extends Node

var _action_list : Array[Action]
var _action_queue : Array[Action]

var dt : float = 1

var active_channels : CHANNEL = 63

enum CHANNEL{
	A = 1, #general
	B = 2, #popups
	C = 4,
	D = 8,
	E = 16,
	F = 32,
}


func _process(delta: float) -> void:
	
	var i : int = 0
	var size : int = _action_list.size()
	
	DebugDraw2D.clear_texts()
	DebugDraw2D.begin_text_group("Stats")
	DebugDraw2D.set_text("Spork Level: %d Stop Tier: %d" % [ProgressManager._spork_level, DopamineManager.shop_tier])
	DebugDraw2D.end_text_group()
	DebugDraw2D.begin_text_group("Actions")
	
	while (i < size):
		var action =	_action_list[i]
		
		DebugDraw2D.set_text("%d " % i + action.a_print() )
		
		#if(!is_active_channel(action)): return
		
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
		
		if(action.blocking): break
		i += 1
		
	DebugDraw2D.end_text_group()
	
	for a in _action_queue:
		_action_list.push_back(a)
	_action_queue.clear()
	
func add_action(action : Action) -> void:
	_action_queue.push_back(action)
	
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
	var blocking: bool
	
	func _init(d :float = 0, block: bool = false, c :CHANNEL = CHANNEL.A) -> void:
		delay = d
		blocking = block
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
		
class GroupAction extends Action:
	var _group_array : Array[Action]
	
	func add_action(action : Action):
		_group_array.push_back(action)
	
	func update(delta:float):
		super(delta)
		
		var i : int = 0
		var size : int = _group_array.size()
		
		if(size <= 0): 
			exit()
			return
			
		DebugDraw2D.begin_text_group("Group Action")
		
		while (i < size):
			var action =	_group_array[i]
			
			DebugDraw2D.set_text("%d " % i + action.a_print() )
			
			#don't worry about channel, the group will take care of it
			
			if(action.is_alive):
				if(action.delay > 0):
					#tick down delay
					action.delay -= delta 
				elif (action.delay > -5):
					action.enter()
				else:
					action.update(delta)
			else:
				_group_array.erase(action)
				size -= 1
				continue
				
			if(action.blocking): break
			
			i += 1
			
		
		DebugDraw2D.end_text_group()
		
	func a_print() ->String:
		return "Group Action : %d" % _group_array.size()

class ActivateNodeAction extends Action:
	
	var object : Node
	
	func _init(obj:Node,d :float = 0, b: bool = false, c :CHANNEL = CHANNEL.A ) -> void:
		super(d,b,c)
		object = obj
	
	func enter():
		object.visible = true
		object.set_process(true)
		exit()
	
	func a_print() -> String:
		return "Activate Node"
	
class DeactivateNodeAction extends Action:
	
	var object : Node
	
	func _init(obj:Node,d :float = 0, b: bool = false, c :CHANNEL = CHANNEL.A ) -> void:
		super(d,b,c)
		object = obj
	
	func enter():
		object.visible = false
		object.set_process(false)
		exit()
		
	func a_print() -> String:
		return "Deactivate Node"

class Move3DAction extends Action:
	
	var start_pos : Vector3
	var end_pos : Vector3
	
	var duration : float
	
	var object : Node3D
	
	var _current_time : float = 0
	
	var _curve : float

	
	func _init(target: Node3D,  start:Vector3, end:Vector3, time: float, curve: float = 1,d:float = 0, b:bool = false, c: CHANNEL = CHANNEL.A)-> void:
		super(d,b,c)
		start_pos = start
		end_pos = end
		duration = time
		object = target
		_curve = curve
		
	func update(delta: float):
		super(delta)
		
		if(_current_time > duration):
			exit()
			return
		
		object.global_position = start_pos.lerp(end_pos,ease(_current_time/duration,_curve))
	
		_current_time += delta
	
	func a_print()-> String:
		return "Move Action : %.2f / %.2f" % [_current_time, duration]

class ChangeColor2DAction extends Action:
	var object : CanvasItem
	var _color : Color
	var _time : float
	var _curve : float
	
	var _current_time : float =0
	var _start_color : Color
	
	func _init(obj: CanvasItem,color: Color,time : float, curve: float = 1,d:float = 0, b:bool = false, c: CHANNEL = CHANNEL.A) -> void:
		super(d,b,c)
		object = obj
		_color = color
		_time = time
		_curve = curve
		
		_start_color = obj.modulate
		
	
	func update(delta: float):
		
		if(_current_time > _time):
			exit()
			return
		
		object.modulate = _start_color.lerp(_color,ease(_current_time/_time,_curve))
		
		_current_time += delta
	
	func exit():
		super()
		object.modulate = _color

	func a_print()-> String:
		return "Change Color Action : %.2f / %.2f" % [_current_time, _time]

class FlashColor2DAction extends GroupAction:
	var object : CanvasItem
	var _color : Color
	var _curve : float
	var _cycle_time : float
	var _cycles : int
	
	var _start_color : Color
	var _current_time : float = 0
	var _current_cycles : int = 0
	
	
	func _init(obj: CanvasItem,color: Color,cycle_time : float, cycles :int,d:float = 0, b:bool = false, c: CHANNEL = CHANNEL.A ) -> void:
		super(d,b,c)
		object = obj
		_color = color
		_cycle_time = cycle_time
		_cycles = cycles
		
		_start_color = obj.modulate
	
	func enter():
		super()
		
		while(_current_cycles < _cycles):
			_group_array.push_back(ChangeColor2DAction.new(object,_color,_cycle_time/2,.2,0,true))
			_group_array.push_back(ChangeColor2DAction.new(object,_start_color,_cycle_time/2,.2,0,true))
			_current_cycles += 1
	
	func exit():
		super()
		object.modulate = _start_color

#region UI Actions
class MoveUIAction extends Action:
	
	var start_pos : Vector2
	var end_pos : Vector2
	
	var duration : float
	
	var object : Control
	
	var _current_time : float = 0
	
	var _curve : float 

	
	func _init(target: Control,  start:Vector2, end:Vector2, time: float,curve:float = 1,d:float = 0, b:bool = false, c: CHANNEL = CHANNEL.A)-> void:
		super(d,b,c)
		start_pos = start
		end_pos = end
		duration = time
		object = target
		_curve = curve
		
	func update(delta: float):
		super(delta)
		
		if(_current_time > duration):
			exit()
			return
		
		object.set_position(start_pos.lerp(end_pos,ease(_current_time/duration,_curve)))
	
		_current_time += delta
		
	func exit():
		super()
		object.set_position(end_pos)
	
	func a_print()-> String:
		return "Move Action : %.2f / %.2f" % [_current_time, duration]
		
class ScaleUIAction extends Action:
	var object : Control
	
	var start_scale : Vector2
	var end_scale : Vector2
	var duration : float
	var _curve : float
	var _current_time : float = 0
		
	func _init(obj: Control, start : Vector2, end: Vector2,time: float,curve:float =1, d:float = 0, b:bool = false, c: CHANNEL = CHANNEL.A ):
		super(b,d,c)
		duration = time
		start_scale = start
		end_scale = end
		object = obj
		_curve = curve
		
	func update(delta: float):
		super(delta)
		
		if(_current_time > duration):
			exit()
			return
		
		object.set_scale(start_scale.lerp(end_scale,ease(_current_time/duration, _curve)))
		
		_current_time += delta
		
	func exit():
		super()
		object.set_scale(end_scale)
	
	func a_print()-> String:
		return "Scale UI Action : %.2f / %.2f" % [_current_time, duration]

class SetVisibleUIAction extends Action:
	var object : Control
	var vis : bool
	
	func _init(obj:Control, is_visible: bool, d:float = 0, b:bool = false, c: CHANNEL = CHANNEL.A) -> void:
		super(d,b,c)
		object = obj
		vis = is_visible
	
	func update(delta: float):
		super(delta)
		object.visible = vis
		exit()
	
class FadeUIAction extends Action:
	var object : Control
	
	var _start_color : Color
	var _end_color : Color
	var duration : float
	var _curve : float
	var _current_time : float = 0
		
	func _init(obj: Control, start_color : Color, end_color: Color,time: float,curve:float =1, d:float = 0, b:bool = false, c: CHANNEL = CHANNEL.A ):
		super(b,d,c)
		duration = time
		_start_color = start_color
		_end_color = end_color
		object = obj
		_curve = curve
		
	func update(delta: float):
		super(delta)
		
		if(_current_time > duration):
			exit()
			return
		
		object.modulate =_start_color.lerp(_end_color,ease(_current_time/duration,_curve))
		
		_current_time += delta
		
	func exit():
		super()
		object.modulate = _end_color
	
	func a_print()-> String:
		return "Scale UI Action : %.2f / %.2f" % [_current_time, duration]
#endregion
