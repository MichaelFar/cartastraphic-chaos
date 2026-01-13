extends RigidBody3D

class_name NPCCart
@export var cartManager : CartManager

@export var possibleShoppingObjects : Array[PackedScene]

@export var numObjectsToSpawn : int = 0

@export var spawnPointContainer : Node3D

var spawnPoints := []

signal front_volume_entered

func _ready() -> void:
	
	cartManager.has_collided.connect(behavior_on_collision)
	spawnPoints = spawnPointContainer.get_children()
	call_deferred("spawn_initial_items")
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


func _on_object_container_body_exited(body: Node3D) -> void:
	if(body is ShoppingObject):	
		
		var shopping_object : ShoppingObject = body
		
		shopping_object.object_secured_in_cart.disconnect(cartManager.add_object_to_list)
		
		body.cartParent = null
		
		if(!body.freeze):
			
			cartManager.pop_from_list(body)
			
		shopping_object.isInCart = false

func spawn_initial_items():
	
	var rand_obj = RandomNumberGenerator.new()
	
	for i in numObjectsToSpawn:
		var rand_index = rand_obj.randi_range(0, possibleShoppingObjects.size() - 1)
		var object_instance = possibleShoppingObjects[rand_index].instantiate()
		rand_index = rand_obj.randi_range(0, spawnPoints.size() - 1)
		GlobalValues.currentLevel.add_child(object_instance)
		object_instance.global_position = spawnPoints[rand_index].global_position


func _on_front_volume_body_entered(body: Node3D) -> void:
	#print("Front of npc cart hit something")
	front_volume_entered.emit()
