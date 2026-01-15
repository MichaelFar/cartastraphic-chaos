extends MeshInstance3D

class_name ShoppingList

@export var shopListAmount : int
@export var individualItemLimit : int = 10
@export var vboxContainer : VBoxContainer

@export var subViewPort : SubViewport
@export var collectedAllItemsColor : Color
@export var notYetCollectedAllItemsColor : Color
var item_track_array : Array[String]

var itemTrackerDict : Dictionary
var originalTrackerDict : Dictionary
var hasAllRequiredItems : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GlobalValues.updated_shopping_list_array.connect(populate_list)
	
	
	
	mesh.material.albedo_texture = subViewPort.get_texture()
	
func populate_list():
	print("Populating shopping list")
	var rand_obj := RandomNumberGenerator.new()
	for i in shopListAmount:
		
		if(vboxContainer.get_children().size() - 3 <= shopListAmount):
			
			var rand_index : int = rand_obj.randi_range(0, GlobalValues.shoppingObjectNameArray.size() - 1)
			
			if(!item_track_array.has(GlobalValues.shoppingObjectNameArray[rand_index])):
				
				item_track_array.append(GlobalValues.shoppingObjectNameArray[rand_index])
				
				var new_label = Label.new()
				
				vboxContainer.add_child(new_label)
				new_label.set("theme_override_colors/font_color",notYetCollectedAllItemsColor)
				new_label.text = GlobalValues.shoppingObjectNameArray[rand_index] + " x 1"
			
			else:
				
				for j in vboxContainer.get_children():
					
					if (j.text.count(GlobalValues.shoppingObjectNameArray[rand_index]) > 0):
						
						if(j.text.to_int() < individualItemLimit):
							
							var num : int = j.text.to_int() + 1
							
							var manipulation_string : String = j.text
							
							manipulation_string = manipulation_string.replace(" x " + str(j.text.to_int()), " x " + str(num))
							
							j.text = manipulation_string
			
	
	itemTrackerDict = {}	
	for i in vboxContainer.get_children():
	
		
		var key : String = i.text
		key = key.replace(" x " + str(i.text.to_int()), "")
		itemTrackerDict.get_or_add(key, i.text.to_int())
		#originalTrackerDict = itemTrackerDict
	
	originalTrackerDict = itemTrackerDict.duplicate()
	
	print("Dictionary is " + str(itemTrackerDict))
	print("Original Dictionary is " + str(originalTrackerDict))

func subtract_then_update_list_labels(item_name : String):
	
	
	if(itemTrackerDict.has(item_name)):
		itemTrackerDict[item_name] = clampi(itemTrackerDict[item_name] - 1, 0, originalTrackerDict[item_name])
		
		update_list_labels(item_name)

func add_then_update_list_labels(item_name : String):
	
	
	if(itemTrackerDict.has(item_name)):
		itemTrackerDict[item_name] = clampi(itemTrackerDict[item_name] + 1, 0, originalTrackerDict[item_name])
		
		print("Item: " + item_name + " is now " + str(itemTrackerDict[item_name]))
		print("Item: dictionary " + str(originalTrackerDict))
		
		update_list_labels(item_name)

func update_list_labels(item_name : String):
	for j in vboxContainer.get_children():
			if(item_name in j.text):
				var manipulation_string : String = j.text
				print("Manipulation string before updating amount is " + manipulation_string)
				print("Replacing item " + item_name+ ": amount " + str(" x " + str(j.text.to_int())) + " with " + str(" x " + str(itemTrackerDict[item_name])))
				
				manipulation_string = manipulation_string.replace(" x " + str(j.text.to_int()), " x " + str(itemTrackerDict[item_name]))
				
				if(!manipulation_string.contains(" x 0")):
					j.set("theme_override_colors/font_color",notYetCollectedAllItemsColor)
				else:
					j.set("theme_override_colors/font_color",collectedAllItemsColor)
				
				print("Manipulation string after updating amount is " + manipulation_string)
				j.text = manipulation_string
	for i in itemTrackerDict:
		if(itemTrackerDict[i] != 0):
			hasAllRequiredItems = false
			return
	
	hasAllRequiredItems = true
