extends Button

func _on_mouse_entered() -> void:
	top_level = true
	
func _on_mouse_exited() -> void:
	top_level = false
