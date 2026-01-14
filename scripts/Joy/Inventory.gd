extends Node3D

@export var total_cost : float

var items : Array[PackedScene]

@export var item_slots: Array[MeshInstance3D]

@export var shopping_list : MeshInstance3D

@export var phone_screen : SubViewport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
