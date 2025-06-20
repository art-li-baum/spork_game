extends Node

@export var cute: CompressedTexture2D
@export var spooky: CompressedTexture2D
@export var fun: CompressedTexture2D


func _ready() -> void:
	ProgressManager.aesthetic.connect(upgrade)

func upgrade(type:int):
	if(DopamineManager.shop_tier != 6): return
	
	match(type):
		1: 
			Input.set_custom_mouse_cursor(cute)
		2:
			Input.set_custom_mouse_cursor(spooky)
		3:
			Input.set_custom_mouse_cursor(fun)
			
