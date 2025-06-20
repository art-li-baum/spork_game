extends Sprite3D

@export var cute : CompressedTexture2D
@export var spooky : CompressedTexture2D
@export var fun : CompressedTexture2D

func _ready() -> void:
	ProgressManager.aesthetic.connect(upgrade)
	
func upgrade(type : int):
	if(DopamineManager.shop_tier != 4): return
	
	match(type):
		1:
			texture = cute
		2:
			texture = spooky
		3:
			texture = fun
