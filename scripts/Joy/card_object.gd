extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewport = $"../Card Viewport"
	viewport.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	
	$".".material_override.albedo_texture = viewport.get_texture()
