extends Control

@export var popups : Array[Control]
@export var message0 : Control
@export var message1 : Control

var remaining : int = 3
func _ready() -> void:
	DopamineManager.shop_upgrade.connect(popup)
	ProgressManager.level_up.connect(message)

func popup():
	if(remaining > -1):
		ActionList.add_action(BasePopUp.PopUpOpenAction.new(popups[remaining],randf()*20+2))
		remaining -= 1

func message(level: int):
	if(level == 12):
		ActionList.add_action(BasePopUp.PopUpOpenAction.new(message0))
	if(level == 17):
		ActionList.add_action(BasePopUp.PopUpOpenAction.new(message1))
