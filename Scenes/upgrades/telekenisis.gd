extends Button

var telekenisis_level : int = 0

var current_cost : int = 10

const progression_level : Array[float] = [.16,2,5,20,50,55,100,120,140]
const progression_cost : Array[int] = [10,10,100,150,300,900,2000,8000,100000]

func _ready() -> void:
	ProgressManager.level_up.connect(check_open)
	ProgressManager.unlock_clock.connect(unlock)
	get_parent().modulate = Color.TRANSPARENT
	visible = false
	
	text = "Unlock Telekinesis (%d) rotations" % current_cost

func _process(delta: float) -> void:
	if(telekenisis_level < 1):
		set_disabled(!RotationManager.has_enough(current_cost))
	else:
		set_disabled(!DopamineManager.has_enough(current_cost))
	
func unlock():
	text = "Upgrade Time Manipulation (%d) dopamine" % current_cost
	ProgressManager.add_spork_level()
	visible = true

func _on_button_pressed():
	
	if(telekenisis_level < 1):
		RotationManager.spend_rotation(current_cost)
		visible = false
	else:
		DopamineManager.spend_dope(current_cost)
		
	RotationManager.spork_add_speed(progression_level[telekenisis_level])
	telekenisis_level += 1
	current_cost = progression_cost[telekenisis_level]
	text = "Upgrade Time Manipulation (%d) dopamine" % current_cost
	
	ProgressManager.add_spork_level()

func check_open(level :int):
	if(level == 1):
		ActionList.add_action(ActionList.FadeUIAction.new(get_parent(),Color.TRANSPARENT,Color.WHITE,0.5))
		visible = true
	
