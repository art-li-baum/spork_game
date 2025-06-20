extends Panel

@export var refreshtext : Control


func _ready() -> void:
	ProgressManager.finale.connect(end)

func end():
	ActionList.add_action(ActionList.ActivateNodeAction.new(self,20))
	ActionList.add_action(ActionList.SetVisibleUIAction.new(refreshtext,true))
	
	

class RESTART extends ActionList.Action:
	var n : Node
	
	func _init( node : Node, delay : float):
		super(delay)
		n = node
	
	func enter():
		super()
		n.get_tree().reload_current_scene()
		
