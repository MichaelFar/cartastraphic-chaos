extends Node3D

@export var smallItemsPackedScenes : Array[PackedScene]
@export var mediumItemsPackedScenes : Array[PackedScene]
@export var largeItemsPackedScenes : Array[PackedScene]

@export var smallSpawnContainers : Array[Node3D]

@export var mediumSpawnContainers : Array[Node3D]

@export var largeSpawnContainers : Array[Node3D]

@export var smallItemsSpawnLimit : int = 10
@export var mediumItemsSpawnLimit : int = 10
@export var largeItemsSpawnLimit : int = 10

func _ready() -> void:
	spawn_objects()

func spawn_objects():
	
	var rand_obj := RandomNumberGenerator.new()
	var small_item_counter : int = 0
	var medium_item_counter : int = 0
	var large_item_counter : int = 0
	for i in smallSpawnContainers:
		
		for j in i.get_children():
			
			if(small_item_counter < smallItemsSpawnLimit):
				var rand_index := rand_obj.randi_range(0, smallItemsPackedScenes.size() - 1)
				var object_instance := smallItemsPackedScenes[rand_index].instantiate()
				add_child(object_instance)
				object_instance.global_position = j.global_position
			small_item_counter += 1
	for i in mediumSpawnContainers:
		
		for j in i.get_children():
			if(medium_item_counter < mediumItemsSpawnLimit):
				var rand_index := rand_obj.randi_range(0, mediumItemsPackedScenes.size() - 1)
				var object_instance := mediumItemsPackedScenes[rand_index].instantiate()
				add_child(object_instance)
				object_instance.global_position = j.global_position
			medium_item_counter += 1
	for i in largeSpawnContainers:
		
		for j in i.get_children():
			
			if(large_item_counter < largeItemsSpawnLimit):
				var rand_index := rand_obj.randi_range(0, largeItemsPackedScenes.size() - 1)
				var object_instance := largeItemsPackedScenes[rand_index].instantiate()
				add_child(object_instance)
				object_instance.global_position = j.global_position
			large_item_counter += 1
