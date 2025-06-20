extends ShopButton

@export var spork_type : int

func on_buy():
	super()
	ProgressManager.new_spork.emit(spork_type)
	if(spork_type >= 9):
		#do finale stuff here
		ProgressManager.finale.emit()
		pass
	disabled = true
