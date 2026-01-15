extends Node

var player : Player

var currentLevel : Node3D

var numSecurity : int = 0 :
	set(value):
		numSecurity = value
		print("Setting security num to " + str(numSecurity))

var numShoppers : int = 0

var shopperLimit : int = 20

var securityLimit : int = 5

var playerMoney : float = 0.0

var shoppingObjectNameArray : Array[String] 

signal updated_shopping_list_array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().scaling_3d_scale

func get_loser_cart(cart1 : CartManager, cart2 : CartManager) -> CartManager:
	
	return cart1 if cart1.get_weight_of_items() <= cart2.get_weight_of_items() else cart2

func shake_player_camera(shake_period : float = 0.3, shake_magnitude : float = 0.4):
	player._camera_shake(shake_period, shake_magnitude)

func check_security_limit() -> bool:
	
	return numSecurity < securityLimit

func check_shopper_limit() -> bool:
	
	return numShoppers < shopperLimit

func add_name_to_list(name_to_add : String):
	if(name_to_add in shoppingObjectNameArray):
		return
	else:
		shoppingObjectNameArray.append(name_to_add)
		updated_shopping_list_array.emit()
		
