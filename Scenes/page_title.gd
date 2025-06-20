extends RichTextLabel

@export var cute : Control
@export var fun : Control
@export var spook : Control
@export var sub : Control

@export var c : AnimatedSprite2D
@export var s : AnimatedSprite2D
@export var f : AnimatedSprite2D


func _ready() -> void:
	ProgressManager.unlock_title.connect(unlock)
	ProgressManager.aesthetic.connect(upgrade)
	modulate = Color.TRANSPARENT

func upgrade(type:int):
	if(DopamineManager.shop_tier == 2):
		text = ""
		sub.visible = false
		match(type):
			1:
				cute.visible = true
			2:
				spook.visible = true
			3: 
				fun.visible = true
			
	if(DopamineManager.shop_tier == 3): 
		match(type):
			1:
				c.visible = true
				c.play()
			2:
				s.visible = true
				s.play()
			3: 
				f.visible = true
				f.play()

func unlock():
	ActionList.add_action(ActionList.FadeUIAction.new(self,Color.TRANSPARENT,Color.WHITE,1))
