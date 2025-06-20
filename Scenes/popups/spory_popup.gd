class_name Sporky extends BasePopUp

@export var label : RichTextLabel
@export var sprite : AnimatedSprite2D

func _ready() -> void:
	super()
	ProgressManager.level_up.connect(level)
	ProgressManager.finale.connect(final)


func final():
		sprite.play("look")
		sprite.speed_scale =2 
		label.text = "IM SORRY IM SORRY IM SORRY IM SORRYIM SORRYIM SORRYIM SORRYIM SORRYIM SORRY"
		ActionList.add_action(PopUpOpenAction.new(self,2))

func level(l:int):
	match(l):
		3: 
			sprite.play("idle")
			label.text = "Hi! I'm Sporky! Looks like you're trying to rotate sporks!"
			ActionList.add_action(PopUpOpenAction.new(self))
		7: 
			sprite.play("idle")
			label.text = "Did you know that you can press on the button to make the spork spin?"
			ActionList.add_action(PopUpOpenAction.new(self))
		10: 
			sprite.play("look")
			label.text = "Uh oh. Looks like you are having issues with time dilation and spork bendies."
			ActionList.add_action(PopUpOpenAction.new(self))
		15:
			sprite.play("idle")
			label.text = "The spork was invented by Samuel W. Francis, who received a U.S. patent for it in 1874,"
			ActionList.add_action(PopUpOpenAction.new(self,.7))
		18: 		
			sprite.play("look")
			label.text = "KEEP IT GOING. IT NEEDS TO GO FASTER. NEVER SLOWER. ALWAYS FASTER. GO GO GO GO."
			ActionList.add_action(PopUpOpenAction.new(self,.2))
