extends Control

var inventory = null  # This will be a reference to the Inventory.gd instance

func set_inventory(inventory_instance):
	inventory = inventory_instance
	update_inventory_display()

func update_inventory_display():
	# Clear existing items from the HUD
	$VBoxContainer.clear_children()
	
	# Add items from the inventory
	for item_name in inventory.items.keys():
		var quantity = inventory.get_quantity(item_name)
		
		# Create a new HBoxContainer for each item
		var item_entry = HBoxContainer.new()
		
		# Add item icon (assuming you have icons for each item)
		var item_icon = TextureRect.new()
		item_icon.texture = load("res://assets/images/lore/" + "1"  + ".png")  # Update path as needed
		item_entry.add_child(item_icon)
		
		# Add item label
		var item_label = Label.new()
		item_label.text = item_name + " x" + str(quantity)
		item_entry.add_child(item_label)
		
		# Add this entry to the VBoxContainer
		$VBoxContainer.add_child(item_entry)
