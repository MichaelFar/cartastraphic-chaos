extends Node3D

class_name Wallet_Item

@export var viewport : SubViewport

@export var planes : Array[MeshInstance3D]

func create_card(item : Control) -> void:
	viewport.add_child(item.duplicate())
	viewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	for i in planes:
		i.material_override.albedo_texture = viewport.get_texture()
