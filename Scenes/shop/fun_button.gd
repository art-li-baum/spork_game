extends ShopButton

@export var label : Label

func populate_shop(cost : int):
	current_cost = cost - 5000
	label.text = "Have some fun!, random upgrade for 5000 less!" 

func on_buy():
	super()
	if(randf() > 0.5):
		DopamineManager.upgrade_dps()
	else:
		DopamineManager.upgrade_cap()
		
	ProgressManager.aesthetic.emit(3)
	get_parent().get_parent().complete_purchase()
