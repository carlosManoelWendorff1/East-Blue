extends Node
signal inventory_updated

var items = {}

func add_item(item_name: String, quantity: int = 1) -> void:
	if item_name in items:
		items[item_name] += quantity
	else:
		items[item_name] = quantity
	emit_signal("inventory_updated")

func remove_item(item_name: String, quantity: int = 1) -> bool:
	if item_name in items and items[item_name] >= quantity:
		items[item_name] -= quantity
		if items[item_name] <= 0:
			items.erase(item_name)
		print("Removed:", item_name, "x", quantity)
		return true
	return false

func get_quantity(item_name: String) -> int:
	return items.get(item_name, 0)
