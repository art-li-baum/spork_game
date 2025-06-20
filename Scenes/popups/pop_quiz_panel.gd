class_name PopupQuiz extends Panel

func _ready() -> void:
	ActionList.add_action(PopUpQuizAction.new(self))
	visible = false
	set_process(false)
	scale = Vector2.ONE *0.1
	global_position = Vector2(400,800)
	
	pass

func check_answer(answer : String):
	if(answer.to_int() == 4):
		#close and add mental power
		ProgressManager.add_spork_level()
		ActionList.add_action(PopUpQuizCloseAction.new(self))
		pass
	else:
		ActionList.add_action(ActionList.FlashColor2DAction.new(self,Color.RED,0.1,3))
		pass


class PopUpQuizAction extends ActionList.GroupAction:
	
	var popup : Control
	
	func _init(obj: Control,d :float = -1, b: bool = false, c :CHANNEL = CHANNEL.B) -> void:
		super(d,b,c)
		popup = obj

		
	func enter():
		#check to see if conditions are met before popping up
		if(RotationManager.total_spork_y_rotations < 3): 
			delay = -1 #delay until condition is met
			return
		
		super()
		#deactivate everything but the popup channel
		#ActionList.deactivate_channel(61)
		
		popup.visible = true
		
		_group_array.push_back(ActionList.ScaleUIAction.new(popup,Vector2.ONE *0.1,Vector2.ONE,0.5,0.2))
		_group_array.push_back(ActionList.MoveUIAction.new(popup,Vector2(400,800),Vector2(500,250),0.5,0.2,0,true))
		_group_array.push_back(ActionList.ActivateNodeAction.new(popup))
		
	func a_print()-> String:
		return "Popup Quiz Action : %.2f / %.2f" % [RotationManager.total_spork_y_rotations, 3]
	
	
class PopUpQuizCloseAction extends ActionList.GroupAction:
	
	var popup : Control
	
	func _init(obj: Control,d :float = -1, b: bool = false, c :CHANNEL = CHANNEL.B) -> void:
		super(d,b,c)
		popup = obj

		
	func enter():
		super()
		#activate again
		#ActionList.activate_channel(61)
		
		
		_group_array.push_back(ActionList.ScaleUIAction.new(popup,Vector2.ONE ,Vector2.ONE*0.1,0.5,0.2))
		_group_array.push_back(ActionList.MoveUIAction.new(popup,popup.position,Vector2(500,800),0.5,0.2,0,true))
		_group_array.push_back(ActionList.DeactivateNodeAction.new(popup))
		
	func a_print()-> String:
		return "Popup Quiz Close Action : %d" % _group_array.size()
