extends Button

@export var menu : Control

@export var viewport : SubViewport

func _on_pressed() -> void:
	menu.hide()
	if(viewport.get_child(0) is CreditCard):
		viewport.get_child(0).on_selected()
