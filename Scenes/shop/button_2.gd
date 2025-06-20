extends ShopButton

func on_buy():
	super()
	
	ProgressManager.unlock_title.emit()
	disabled = true
