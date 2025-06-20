class_name ShopButton extends Button

@export var current_cost : int

func on_click():
	if(RotationManager.has_enough(current_cost)):
		on_buy()
	else:
		ActionList.add_action(ActionList.FlashColor2DAction.new(self,Color.RED,0.1,3))
		

func on_buy():
	RotationManager.spend_rotation(current_cost)

func populate_shop(cost : int):
	pass
