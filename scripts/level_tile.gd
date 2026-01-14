extends Node3D

class_name LevelTile
# Called when the node enters the scene tree for the first time.
@export var npcSpawnMarkerParent : Node3D

@export var ordinaryNPCPackedScene : PackedScene

@onready var npcSpawnMarkers := []

@export var isSecurityTile : bool = false

var securityPackedScene := preload("res://scenes/Security_NPC.tscn")

func _ready() -> void:
	
	npcSpawnMarkers = npcSpawnMarkerParent.get_children()
	npc_respawn_loop()
	
	
	
func spawn_npcs():
	print("Spawning npcs")
	for i in npcSpawnMarkers:
		if(GlobalValues.check_shopper_limit()):
			GlobalValues.numShoppers += 1
			var npc_instance := ordinaryNPCPackedScene.instantiate()
			call_deferred("add_child",(npc_instance))
			npc_instance.global_position = i.global_position
		
func spawn_security():
	print("Spawning security")
	
	for i in npcSpawnMarkers:
		if(GlobalValues.check_security_limit()):
			GlobalValues.numSecurity += 1
			var npc_instance := securityPackedScene.instantiate()
			call_deferred("add_child",(npc_instance))
			npc_instance.global_position = i.global_position

func npc_respawn_loop():
	spawn_security()
	spawn_npcs()
	var timer = get_tree().create_timer(20)
	timer.timeout.connect(npc_respawn_loop)
