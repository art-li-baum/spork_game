class_name BasePopUp extends TextureRect


func dismiss():
	ActionList.add_action(PopUpCloseAction.new(self))
	
func _ready() -> void:
	visible = false
	set_process(false)
	scale = Vector2.ONE *0.1
	global_position = Vector2(400,800)


class PopUpCloseAction extends ActionList.GroupAction:
	
	var popup : Control
	
	
	func _init(obj: Control,d :float = -1, b: bool = false, c :CHANNEL = CHANNEL.A) -> void:
		super(d,b,c)
		popup = obj

		
	func enter():
		super()

		_group_array.push_back(ActionList.ScaleUIAction.new(popup,Vector2.ONE ,Vector2.ONE*0.1,0.5,0.2))
		_group_array.push_back(ActionList.MoveUIAction.new(popup,popup.position,Vector2(500,800),0.5,0.2,0,true))
		_group_array.push_back(ActionList.DeactivateNodeAction.new(popup))
		
	func a_print()-> String:
		return "Popup Close Action : %d" % _group_array.size()

class PopUpOpenAction extends ActionList.GroupAction:
	
	var popup : Control
	
	var start_pos : Vector2
	var end_pos: Vector2
	
	func _init(obj: Control,d :float = -1, b: bool = false, c :CHANNEL = CHANNEL.A) -> void:
		super(d,b,c)
		popup = obj
		start_pos = obj.position
		end_pos = Vector2(randf()*650,randf()*340+10)
		
	func enter():
		super()
		
		popup.visible = true
		
		_group_array.push_back(ActionList.ScaleUIAction.new(popup,Vector2.ONE *0.1,Vector2.ONE,0.5,0.2))
		_group_array.push_back(ActionList.MoveUIAction.new(popup,start_pos,end_pos,0.5,0.2,0,true))
		_group_array.push_back(ActionList.ActivateNodeAction.new(popup))
