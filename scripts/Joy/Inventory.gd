extends Node3D

class_name Inventory

var possible_items : Array[PackedScene]

@export var item_slots: Array[MeshInstance3D]
@onready var item_heights = [0, 0, 0, 0]
@export var height_variation : float

@export var shopping_list : MeshInstance3D

@export var phone_screen : SubViewport

@export var wallet_item : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#generate shopping cart
	pass # Replace with function body.

func add_to_inventory(item : Node) -> void:
	var what_item : MeshInstance3D
	var number = randi_range(0, 3)
	what_item = item_slots[number]
	
	what_item.add_child(wallet_item.instantiate())
	var created_item = what_item.get_child(what_item.get_child_count() - 1)
	created_item.create_card(item)
	created_item.rotation.y = randf_range(0, 360)
	created_item.position.y += item_heights[number] * height_variation
	item_heights[number] += 1
	
