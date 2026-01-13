extends Node3D

class_name ProceduralLevelGenerator

@export var possibleTilePackedScenes : Array[PackedScene]

var tileScenes

var markerChildren : Array[Node]

func _ready() -> void:
	markerChildren = get_children()
	await get_parent().ready
	populate_tiles()
func populate_tiles():
	var rand_obj := RandomNumberGenerator.new()
	
	for i in markerChildren:
		var rand_index := rand_obj.randi_range(0, possibleTilePackedScenes.size() - 1)
		var tile_instance := possibleTilePackedScenes[rand_index].instantiate()
		GlobalValues.currentLevel.add_child(tile_instance)
		#GlobalValues.currentLevel.call_deferred("add_child",tile_instance) 
		#set_process(false)
		#await tile_instance.ready
		#set_process(true)
		tile_instance.rotation_degrees.y = rand_obj.randi_range(0, 3) * 90
		tile_instance.global_position = i.global_position
		
