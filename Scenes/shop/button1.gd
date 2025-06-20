extends ShopButton

func on_buy():
	super()
	
	ProgressManager.unlock_clock.emit()
	disabled = true
