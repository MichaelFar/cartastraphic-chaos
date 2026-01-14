extends Node3D

class_name CartManager

var shoppingObjectList : Array[ShoppingObject]

@export var cartOwner : Node3D
# Called when the node enters the scene tree for the first time.
@export var shouldEject : bool = true

@export var testTimer : Timer

@export var ejectPointContainer : Node3D
var ejectPointList := []

signal has_ejected

signal has_collided

func _ready():
	ejectPointList = ejectPointContainer.get_children()

func add_object_to_list(new_item : ShoppingObject):
	
	if new_item not in shoppingObjectList:
		print("Adding object to list")
		shoppingObjectList.append(new_item)

func pop_from_list(object_to_remove : ShoppingObject):
	
	if object_to_remove in shoppingObjectList:
		print("Popping" + str(object_to_remove))
		shoppingObjectList.pop_at(shoppingObjectList.find(object_to_remove))

func eject_item(object_to_eject : ShoppingObject):
	
	if(object_to_eject != null):
		
		object_to_eject.freeze = false
		object_to_eject.lock_rotation = false
		
		if(object_to_eject.targetNode != null):
			
			object_to_eject.targetNode.queue_free()
		
		var rand_obj := RandomNumberGenerator.new()
		var rand_index := rand_obj.randi_range(0,ejectPointList.size() - 1)
		
		object_to_eject.apply_force_towards_global_point(ejectPointList[rand_index], false, 0.01, 10)
		

func get_random_object() -> ShoppingObject:
	
	var rand_obj = RandomNumberGenerator.new()
	var output_shopping_object = null
	if(shoppingObjectList.size() > 0):
		
		output_shopping_object = shoppingObjectList[rand_obj.randi_range(0, shoppingObjectList.size() - 1)]
	return output_shopping_object

func eject_all_items():
	for i in shoppingObjectList:
		eject_item(i)
	has_ejected.emit()

func eject_random_item():
	
	eject_item(get_random_object())

func _on_test_eject_timer_timeout() -> void:
	if(shouldEject):
		eject_all_items()
		testTimer.start()

func get_weight_of_items() -> float:
	var weight : float = 0.0
	for i in shoppingObjectList:
		weight += i.weight
	return weight

func get_total_price() -> float:
	
	var price: float = 0.0
	for i in shoppingObjectList:
		price += i.price
	return price
