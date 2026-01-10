extends Node3D

@export var smallItemsPackedScenes : Array[PackedScene]
@export var mediumItemsPackedScenes : Array[PackedScene]
@export var largeItemsPackedScenes : Array[PackedScene]

@export var smallSpawnContainers : Array[Node3D]

@export var mediumSpawnContainers : Array[Node3D]

@export var largeSpawnContainers : Array[Node3D]

func _ready() -> void:
	spawn_objects()

func spawn_objects():
	
	var rand_obj := RandomNumberGenerator.new()
	
	for i in smallSpawnContainers:
		
		for j in i.get_children():
			
			var rand_index := rand_obj.randi_range(0, smallItemsPackedScenes.size() - 1)
			var object_instance := smallItemsPackedScenes[rand_index].instantiate()
			GlobalValues.add_child(object_instance)
			object_instance.global_position = j.global_position
	for i in mediumSpawnContainers:
		
		for j in i.get_children():
			
			var rand_index := rand_obj.randi_range(0, mediumItemsPackedScenes.size() - 1)
			var object_instance := mediumItemsPackedScenes[rand_index].instantiate()
			GlobalValues.add_child(object_instance)
			object_instance.global_position = j.global_position
	for i in largeSpawnContainers:
		
		for j in i.get_children():
			
			var rand_index := rand_obj.randi_range(0, largeItemsPackedScenes.size() - 1)
			var object_instance := largeItemsPackedScenes[rand_index].instantiate()
			GlobalValues.add_child(object_instance)
			object_instance.global_position = j.global_position
