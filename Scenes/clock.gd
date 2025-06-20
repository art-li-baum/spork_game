extends RichTextLabel

var time_played : float

var speed : float = 1


func _ready() -> void:
	RotationManager.speed_up.connect(add_speed)
	ProgressManager.unlock_clock.connect(unlock)
	modulate = Color.TRANSPARENT

func add_speed(add : float):
	speed += add

func unlock():
	ActionList.add_action(ActionList.FadeUIAction.new(self,Color.TRANSPARENT,Color.WHITE,1,.2))

func _process(delta: float) -> void:
	time_played += delta * speed
	text = _format_time()

func _format_time()-> String:
	var out = ""
	
	if(time_played >= 29030400):
		out += "%02d" % (time_played/29030400) + "y:"
	
	if(time_played >= 2419200):
		out += "%02d" % (int(time_played/2419200) % 12) + "mo:"
	
	if(time_played >= 86400):
		out += "%02d" % (int(time_played/86400) % 28) + "d:"
	
	if(time_played >= 3600):
		out += "%02d" % (int(time_played/3600) % 24) + "h:"
		
	if(time_played >= 60):
		out += "%02d" % (int(time_played/60) % 60) + "m:"
	
	out+= "%02d" % (int(ceil(time_played)) % 60) + "s"
	
	return out
