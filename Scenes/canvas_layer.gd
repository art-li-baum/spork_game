extends Control

func _ready() -> void:
	ProgressManager.finale.connect(end)


func end():
	ActionList.add_action(Shake.new(self,18,1))



class Shake extends ActionList.GroupAction:
	
	var obj : Control
	
	var dur : float
	var currenttime : float
	
	var originalpos : Vector2

	
	var noise : Noise
	
	func _init(object:Control, duration: float, delay: float) -> void:
		super(delay)
		dur = duration
		obj = object
		originalpos = obj.position
		
	func update(delta: float):
		
		if(currenttime > dur):
			exit()
			return
		
		obj.position = originalpos+ Vector2(randf(),randf()) * 10
		
	func exit():
		super()
		obj.position = originalpos
