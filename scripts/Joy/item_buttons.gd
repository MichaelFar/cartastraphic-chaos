extends Button

@export var menu : Control

@export var viewport : SubViewport

func _on_pressed() -> void:
	menu.hide()
