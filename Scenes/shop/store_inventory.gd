class_name Inventory extends TextureRect

@export var basic : Control
@export var level2 : Control
@export var level3 : Control
@export var finale : Control
@export var desc_1 : Label
@export var desc_2 : Label
@export var desc_3 : Label

@export var pricing : Label

@export var cute_butt : ShopButton
@export var spook_butt : ShopButton
@export var fun_butt : ShopButton

@export var level2background : CompressedTexture2D
@export var level3background : CompressedTexture2D
@export var finalebackground : CompressedTexture2D


const progress_cost : Array[int] = [0,10000,20000,50000,90000, 80000,100000,150000]

func _ready() -> void:
	ProgressManager.new_spork.connect(final)

func final(trigger : int):
	if trigger == 8:
		level3.visible = false
		level3.mouse_filter =Control.MOUSE_FILTER_IGNORE
		finale.visible = true
		finale.mouse_filter = Control.MOUSE_FILTER_PASS
		texture = finalebackground
		desc_1.text = "  "
		desc_2.text = " GIVE ALL TO THE SPORK "
		desc_3.text = " "	
		pricing.text = "740280"

func populate_store(i : int = 0):
	if(DopamineManager.shop_tier < 2):
		desc_1.text = " Control the flow of time (50) rots "
		desc_2.text = " Declare your domain (100) rots "
		desc_3.text = " (1000) rots"	
		pricing.text = ""
	elif(DopamineManager.shop_tier < 6):
		basic.mouse_filter =Control.MOUSE_FILTER_IGNORE
		basic.visible = false
		level2.visible = true
		level2.mouse_filter =Control.MOUSE_FILTER_PASS
		pricing.text = "%d rots" % progress_cost[DopamineManager.shop_tier]
		cute_butt.populate_shop(progress_cost[DopamineManager.shop_tier])
		fun_butt.populate_shop(progress_cost[DopamineManager.shop_tier])
		spook_butt.populate_shop(progress_cost[DopamineManager.shop_tier])
	elif(DopamineManager.shop_tier == 7):
		level2.visible = false
		level2.mouse_filter =Control.MOUSE_FILTER_IGNORE
		level3.visible = true
		level3.mouse_filter =Control.MOUSE_FILTER_PASS
		desc_1.text = " EMBRACE THE PASSAGE OF TIME 200k"
		desc_2.text = " RIP INTO REALITY 400k"
		desc_3.text = " JOIN THE GRAND PARTY 600k"	
		pricing.text = "^%)!!)__"
		
		
	match(DopamineManager.shop_tier):
		2: 	
			texture = level2background
		7:
			texture = level3background

func complete_purchase():

	get_parent().close_shop()
