extends MeshInstance3D

@export var viewport : SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().physics_frame
	
