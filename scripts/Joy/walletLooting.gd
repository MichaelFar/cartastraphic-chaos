extends Control

@onready var item_pool = [load("res://scenes/Joy/Wallet Items/CreditCard.tscn"), 
load("res://scenes/Joy/Wallet Items/Cash.tscn"), 
load("res://scenes/Joy/Wallet Items/Cupon.tscn"), 
load("res://scenes/Joy/Wallet Items/Crypto.tscn"), 
load("res://scenes/Joy/Wallet Items/Junk.tscn")]

@onready var items = [$Item1Button/SubViewport, $Item2Button/SubViewport,
$Item3Button/SubViewport, $Item4Button/SubViewport]

@onready var title = $ItemDescription/TitleLabel
@onready var description = $ItemDescription/DescriptionLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Turn on mouse cursor
	Input.set_mouse_mode(0)
	
	#Generate the different items
	generateItems()
	#associate them with the buttons
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#function that 
	pass
	
func generateItems() -> void:
	var randomizeItems : Array[int] = [0, randi_range(0, 100), randi_range(0, 100), randi_range(-300, 100)]
	for i in 4: 
		print(randomizeItems[i])
		if(randomizeItems[i] < 0):
			items[i].get_parent().queue_free()
		elif(randomizeItems[i] < 20):
			items[i].add_child(item_pool[0].instantiate())
		elif(randomizeItems[i] < 50):
			items[i].add_child(item_pool[1].instantiate())
		elif(randomizeItems[i] < 60):
			items[i].add_child(item_pool[3].instantiate())
		elif(randomizeItems[i] <= 100):
			items[i].add_child(item_pool[4].instantiate())
