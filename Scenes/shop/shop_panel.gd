extends Panel

@export var closed_door_button : Button
@export var closed_door : Control
@export var knock1 : Control
@export var knock2 : Control
@export	var bang : Control
@export	var shop : Control

@export var shop_inv: Inventory


func _ready() -> void:
	reveal_shop(1)
	reveal_shop(2)
	reveal_shop(3)
	reveal_shop(4)
	reveal_shop(5)
	reveal_shop(6)
	reveal_shop(7)
	visible = false
	pass
	
func reveal_shop(tier : int):
	ActionList.add_action(OpenShopAction.new(self,tier))
	
func close_shop():
	DopamineManager.reopen_store.emit()
	visible = false
	shop.visible = false
	closed_door_button.visible = true
	closed_door.visible = true
	closed_door_button.disabled = false

func knock_on_door():
	closed_door_button.disabled = true
	closed_door_button.visible = false
	shop_inv.populate_store()
	ActionList.add_action(DoorKnockAction.new(closed_door,knock1,knock2,bang,shop))

func _process(delta: float) -> void:
	if(DopamineManager.shop_tier >6):
		self_modulate = Color.TRANSPARENT

class CloseShopAction extends ActionList.GroupAction:
	var _base : Control
	var _closed_door : Control
	var _door : Control
	
	
	func _init(base: Control, closed_door: Control, door:Control):
		super(0,true)
		_base = base
		_closed_door = closed_door
		_door = door
		
	func enter():
		super()
		
		_group_array.push_back(ActionList.SetVisibleUIAction.new(_base,false))
		_group_array.push_back(ActionList.SetVisibleUIAction.new(_closed_door,true))
		_group_array.push_back(ActionList.SetVisibleUIAction.new(_door,true))
		


class OpenShopAction extends ActionList.GroupAction:
	var base : Control
	
	var _tier : int 
	
	func _init(sh:Control,tier : int) -> void:
		base = sh
		_tier = tier
	
	func enter():
		#trigger parameter
		if(DopamineManager.shop_tier < _tier):
			return
			
		super()
		
		_group_array.push_back(ActionList.SetVisibleUIAction.new(base,true))
		_group_array.push_back(ActionList.FadeUIAction.new(base,Color.TRANSPARENT,Color.WHITE,1))
		

class DoorKnockAction extends ActionList.GroupAction:
	
	var closed_door : Control
	var knock1 : Control
	var knock2 : Control
	var bang : Control
	var shop : Control
	
	func _init(closedoor : Control, kn1:Control,kn2:Control,b:Control,sh:Control) -> void:
		super()
		closed_door = closedoor
		knock1 = kn1
		knock2 = kn2
		bang = b
		shop = sh
		
	func enter():
		super()
		
		#knock knock
		_group_array.push_back(ActionList.SetVisibleUIAction.new(knock1,true,0.2,true))
		_group_array.push_back(ActionList.SetVisibleUIAction.new(knock2,true,0.1,true))
		_group_array.push_back(ActionList.SetVisibleUIAction.new(knock1,false,0.3,false))
		_group_array.push_back(ActionList.SetVisibleUIAction.new(knock2,false,0.3,true))
		#pause then bang
		_group_array.push_back(ActionList.SetVisibleUIAction.new(closed_door,false,1.2,true))
		_group_array.push_back(ActionList.SetVisibleUIAction.new(bang,true,0,true))
		_group_array.push_back(ActionList.SetVisibleUIAction.new(bang,false,0.4,true))
		#show shop
		_group_array.push_back(ActionList.SetVisibleUIAction.new(shop,true))
