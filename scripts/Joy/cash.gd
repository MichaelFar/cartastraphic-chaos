extends Control

@export var value: int

@onready var item_name: String = "Cash"
@onready var item_description: String = "Some cold hard cash. No Strings attached"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand = randi_range(0, 100)
	if(rand <= 50):
		value = 5
	elif (rand <= 75):
		value = 10
	elif (rand < 99):
		value = 20
	else:
		value = 50
	
	$DollarAmount.text = "$" + str(value)
	$DollarAmount2.text = "$" + str(value)
	$DollarAmount3.text = "$" + str(value)
	$DollarAmount4.text = "$" + str(value)
	
	tooltip_text = item_name + "\n" + item_description
