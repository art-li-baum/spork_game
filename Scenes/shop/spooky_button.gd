extends ShopButton

@export var label : Label

func populate_shop(cost : int):
	current_cost = cost
	label.text = "Kill Heaven, upgrade Dope Capacity to tier %d" % DopamineManager.cap_level
	
func on_buy():
	super()
	ProgressManager.aesthetic.emit(2)
	get_parent().get_parent().complete_purchase()
	DopamineManager.upgrade_cap()
