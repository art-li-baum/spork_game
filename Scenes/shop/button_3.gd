extends ShopButton

func on_buy():
	super()

	get_parent().get_parent().complete_purchase()
	
