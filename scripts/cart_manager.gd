extends Node3D

class_name CartManager

var shoppingObjectList : Array[ShoppingObject]
# Called when the node enters the scene tree for the first time.
@export var testTimer : Timer
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
			
		
		object_to_eject.apply_central_impulse(object_to_eject.basis.z * 40)

func get_random_object() -> ShoppingObject:
	
	var rand_obj = RandomNumberGenerator.new()
	var output_shopping_object = null
	if(shoppingObjectList.size() > 0):
		
		output_shopping_object = shoppingObjectList[rand_obj.randi_range(0, shoppingObjectList.size() - 1)]
	return output_shopping_object

func eject_random_item():
	
	eject_item(get_random_object())

func _on_test_eject_timer_timeout() -> void:
	eject_random_item()
	testTimer.start()
