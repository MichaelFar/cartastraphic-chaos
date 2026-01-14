extends Control

@export var item_pool : Array[PackedScene]

@export var items : Array[SubViewport]

func _ready() -> void:
	pass
	#show()

func _on_visibility_changed() -> void:
	if visible:
		print("visible")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		generateItems()
	elif hidden:
		print("hidden")
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		degenerateItems()

func generateItems() -> void:
	var randomizeItems : Array[int] = [0, randi_range(0, 100), randi_range(0, 100), randi_range(-300, 100)]
	for i in 4: 
		print(randomizeItems[i])
		if(randomizeItems[i] < 0):
			#items[i].get_parent().queue_free()
			pass
		elif(randomizeItems[i] < 20):
			items[i].add_child(item_pool[0].instantiate())
		elif(randomizeItems[i] < 50):
			items[i].add_child(item_pool[1].instantiate())
		elif(randomizeItems[i] < 60):
			items[i].add_child(item_pool[2].instantiate())
		else:
			items[i].add_child(item_pool[3].instantiate())

func degenerateItems() -> void:
	for i in items:
		if i.get_child_count() == 1:
			i.get_child(0).queue_free()
