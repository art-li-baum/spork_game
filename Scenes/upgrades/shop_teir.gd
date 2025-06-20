extends Button

const progression_costs : Array[int] = [100,100,500,1000,2000,4000,5000,10000,12000,20000]

var current_cost : int

func _ready() -> void:
	ProgressManager.level_up.connect(unlock)
	DopamineManager.reopen_store.connect(reopen)
	current_cost = progression_costs[DopamineManager.shop_tier]
	text = "Run Setup Wizard (%d) rots" % current_cost
	visible = false
	modulate = Color.TRANSPARENT

func _process(delta: float) -> void:
	if(ProgressManager._spork_level < 4):
		set_disabled(!RotationManager.has_enough(current_cost))
	else:
		set_disabled(!DopamineManager.has_enough(current_cost))

func upgrade():
	if(ProgressManager._spork_level < 4):
		RotationManager.spend_rotation(current_cost)
	else:
		DopamineManager.spend_dope(current_cost)
	
	visible = false
	
	DopamineManager.upgrade_shop()
	var c =progression_costs[DopamineManager.shop_tier]
	current_cost = clampf(c,c,DopamineManager.dopamine_capacity)
	
	text = "Run Setup Wizard (%d) dopamine" % current_cost

func reopen():
	visible = true
	current_cost = progression_costs[DopamineManager.shop_tier]
	ActionList.add_action(ActionList.FadeUIAction.new(self,Color.TRANSPARENT,Color.WHITE,2,1,5))

func unlock(level : int):
	if(level == 3):
		reopen()
