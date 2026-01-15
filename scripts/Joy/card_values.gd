extends Control

@export var value: float
@export var pin: int
@export var expired: bool

@onready var item_name : String = "Credit Card" 
@onready var item_description : String = "  Some schmuck's credit card."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if value != 0 and pin != 0:
		randomizeValues()
		randomizeAppearance()
		tooltip_text = item_name + "\n" + item_description
	else:
		setCard()

# Randomizes the background, 
func randomizeAppearance() -> void:
	print("randomizing")
	$"Card Number".text = str(randi_range(0, 9999)) + " " +str(randi_range(0, 9999)) + " " + str(randi_range(0, 9999)) + " " + str(randi_range(0, 9999))
	$"Expiration Date".text = str(str(randi_range(1, 12)) + " / " + str(randi_range(27, 30) if !expired else randi_range(0,25) ))
	$Background.texture = ImageTexture.create_from_image(Image.load_from_file("res://scenes/Joy/Visuals/CreditCard/bg_hex2.png"))
	$Background.modulate = Color(randf(), randf(), randf())
	$"Card holder name".text = "Bingus Bongus"

# Randomizes the money on the card, the pin, and if the card is expired or not
func randomizeValues() -> void:
	value = randi_range(199, 9000) 
	value /= 100
	$"Money Left".text = "Money Left:\n" + str(value)
	item_description = item_description + " It still has " + str(value) + " left on it."
	
	pin = randi_range(100, 999)
	$Pin.text = str(pin)
	
	if randi_range(1, 20) == 1:
		expired = true
		item_name = "Expired Credit Card"
		$"Card Icon".queue_free()
	else:
		expired = false
	

func setCard() -> void:
	$"Money Left".text = "Money Left:\n" + str(value)
	$Pin.text = str(pin)
	$"Card holder name".text = "Me!"
	$Background.texture = ImageTexture.create_from_image(Image.load_from_file("res://scenes/Joy/Visuals/CreditCard/bg_hex2.png"))
	$Background.modulate = Color(randf(), randf(), randf())
	$"Card Number".text = str(randi_range(0, 9999)) + " " +str(randi_range(0, 9999)) + " " + str(randi_range(0, 9999)) + " " + str(randi_range(0, 9999))
