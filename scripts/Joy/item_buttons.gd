extends Button

@export var menu : Control

@export var inventory : Inventory

@export var viewport : SubViewport

func _on_pressed() -> void:
	inventory.add_to_inventory(viewport.get_child(0))
	menu.hide()
	if(viewport.get_child(0) is CreditCard):
		viewport.get_child(0).on_selected()
