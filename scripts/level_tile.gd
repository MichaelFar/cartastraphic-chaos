extends Node3D

class_name LevelTile
# Called when the node enters the scene tree for the first time.
@export var npcSpawnMarkerParent : Node3D

@export var ordinaryNPCPackedScene : PackedScene

@onready var npcSpawnMarkers := []

func _ready() -> void:
	
	npcSpawnMarkers = npcSpawnMarkerParent.get_children()
	spawn_npcs()
	
func spawn_npcs():
	
	for i in npcSpawnMarkers:
		
		var npc_instance := ordinaryNPCPackedScene.instantiate()
		call_deferred("add_child",(npc_instance))
		npc_instance.global_position = i.global_position

func reparent_npcs():
	pass
