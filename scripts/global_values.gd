extends Node

var player : Player

var currentLevel : Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().scaling_3d_scale

func get_loser_cart(cart1 : CartManager, cart2 : CartManager) -> CartManager:
	
	return cart1 if cart1.get_weight_of_items() <= cart2.get_weight_of_items() else cart2
