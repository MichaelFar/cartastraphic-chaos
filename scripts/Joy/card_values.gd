extends Control

var value: float
var pin: int
var expired: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomizeValues()
	randomizeAppearance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	value /= 10
	$"Money Left".text = "Money Left:\n" + str(value)
	
	pin = randi_range(100, 999)
	$Pin.text = str(pin)
	
	if randi_range(1, 20) == 1:
		expired = true
	else:
		expired = false
	
