extends RigidBody3D

class_name NPCCart
@export var cartManager : CartManager


func _ready() -> void:
	cartManager.has_collided.connect(behavior_on_collision)
	
	#GlobalSignalBus.cart_rammed.connect(object_rammed)

func object_rammed(incoming_object: Node3D, other_object : Node3D):
	
	cartManager.eject_all_items()

func _on_object_container_body_entered(body: Node3D) -> void:
	if(body is ShoppingObject):
		var shopping_object : ShoppingObject = body
		body.cartParent = self
		if(!shopping_object.object_secured_in_cart.is_connected(cartManager.add_object_to_list)):
			shopping_object.object_secured_in_cart.connect(cartManager.add_object_to_list)
		shopping_object.isInCart = true

func behavior_on_collision():
	cartManager.eject_all_items()
