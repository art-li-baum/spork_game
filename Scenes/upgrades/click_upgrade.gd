extends Button
var current_cost : int 

const progress_costs : Array[int] = [15,20,50,500,1500,4000,10000,25000,70000,1000000]
const progress_level : Array[float] = [.33,5,25,80,120,300,800,2000,10000]

var strength_level = 0

func _ready() -> void:
	pressed.connect(upgrade)
	ProgressManager.level_up.connect(level_check)
	ProgressManager.unlock_title.connect(unlock)
	visible = false
	current_cost = progress_costs[0]
	RotationManager.click_strength = progress_level[0]
	text = "Stronger Clicks (%d)" % current_cost

func _process(delta: float) -> void:
	if(ProgressManager._spork_level < 3):
		set_disabled(!RotationManager.has_enough(current_cost))
	else:
		set_disabled(!DopamineManager.has_enough(current_cost))
	
func unlock():
	text = "Stronger Clicks (%d)" % current_cost
	ProgressManager.add_spork_level()
	visible = true
	
func upgrade():
		
	if(ProgressManager._spork_level <3):
		visible = false
		if(RotationManager.has_enough(current_cost)):
			RotationManager.spend_rotation(current_cost)
	else:
		if(DopamineManager.has_enough(current_cost)):
			DopamineManager.spend_dope(current_cost)
		
	
	strength_level += 1
	RotationManager.click_strength += progress_level[strength_level]
	current_cost = progress_costs[strength_level]
	text = "Stronger Clicks (%d)" % current_cost
	ProgressManager.add_spork_level()

func level_check(level : int):
	if level == 2:
		ActionList.add_action(ActionList.SetVisibleUIAction.new(self,true,5))
