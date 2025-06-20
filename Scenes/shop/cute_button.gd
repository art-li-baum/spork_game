extends ShopButton

@export var label : Label

func populate_shop(cost : int):
	current_cost = cost
	label.text = "Search your heart, upgrade DPR to tier %d" % DopamineManager.dps_level

func on_buy():
	super()
	DopamineManager.upgrade_dps()
	ProgressManager.aesthetic.emit(1)
	get_parent().get_parent().complete_purchase()
