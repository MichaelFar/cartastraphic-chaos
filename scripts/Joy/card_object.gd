extends MeshInstance3D

@export var viewport : SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().physiscs_frame
	viewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	
	$".".material_override.albedo_texture = viewport.get_texture()
