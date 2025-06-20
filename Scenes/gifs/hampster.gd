extends Control

@export var sprite : CPUParticles2D

@export var cute : AnimatedSprite2D
@export var spooky : AnimatedSprite2D
@export var fun : AnimatedSprite2D

func _ready() -> void:
	ProgressManager.aesthetic.connect(upgrade)
	ProgressManager.finale.connect(end)

func end():
	sprite.emitting = true
	
func upgrade(type : int):
	if(DopamineManager.shop_tier != 5): return
	match(type):
		1:
			cute.visible = true
			cute.play()
		2:
			spooky.visible = true 
			spooky.play()
		3:
			fun.visible = true 
			fun.play()
