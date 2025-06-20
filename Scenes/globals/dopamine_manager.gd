extends Node

var dopamine_capacity: int = 100
var banked_dopamine : int = 0
var dop_rot_ration : int = 10

var shop_tier : int = 0
var dps_level : int = 0
var cap_level : int = 0

var _cached_rot : float = 0

const progress_dps : Array[int] = [20,15,10,9,8,7,6,5,4,3,2,1]
const progress_cap : Array[int] = [100,1000,5000,10000,20000,100000,1000000]

signal shop_upgrade()
signal dpr_upgrade(int)
signal cap_upgrade(int)

signal reopen_store()

func _ready() -> void:
	RotationManager.spork_rotate.connect(gen_dope)
	ProgressManager.unlock_title.connect(upgrade_cap)
	ProgressManager.unlock_clock.connect(upgrade_dps)

func add_dope(ammount : int):
	if(banked_dopamine < dopamine_capacity):
		banked_dopamine = clamp( banked_dopamine + ammount,0,dopamine_capacity)

func gen_dope(delta : float):
	if(shop_tier < 1): return
	
	_cached_rot += delta
	if(_cached_rot >= dop_rot_ration):
		add_dope(int(_cached_rot/dop_rot_ration))
		_cached_rot = 0

func has_enough(cost: int)->bool:
	return cost <= banked_dopamine

func spend_dope(cost: int):
	if(has_enough(cost)):
		banked_dopamine -= cost

func upgrade_shop():
	shop_tier += 1
	shop_upgrade.emit()
	
func upgrade_dps():
	dps_level += 1
	dop_rot_ration = progress_dps[dps_level]
	dpr_upgrade.emit()

func upgrade_cap():
	cap_level += 1
	dopamine_capacity = progress_cap[cap_level]
	cap_upgrade.emit()
