extends Area3D

@export var totalLabel : Label3D

var totalString : String :
	set(value):
		totalString = value
		totalLabel.text = "Your total: " + str(GlobalValues.player.cartManager.get_total_price())
	get():
		return totalString
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label_loop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_label_loop():
	var timer = get_tree().create_timer(3.0)
	timer.timeout.connect(update_label_loop)
	totalString = ""


func _on_body_entered(body: Node3D) -> void:
	if(body is Player):
		if(body.shoppingList.hasAllRequiredItems && GlobalValues.playerMoney >= GlobalValues.player.cartManager.get_total_price()):
			print("You friggin win baby")
		else:
			print("Get back out there shopper!")
