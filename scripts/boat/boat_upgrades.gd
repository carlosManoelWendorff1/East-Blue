extends Node

var upgrades = {
	"speed_boost": false,
	"extra_durability": false
}

func apply_upgrade(boat, upgrade_name: String, inventory) -> void:
	if upgrade_name == "speed_boost" and !upgrades["speed_boost"] and inventory.remove_item("speed_potion", 1):
		upgrades["speed_boost"] = true
		boat.speed += 100
		print("Speed boost applied. New speed:", boat.speed)
	elif upgrade_name == "extra_durability" and !upgrades["extra_durability"] and inventory.remove_item("durability_token", 1):
		upgrades["extra_durability"] = true
		print("Durability upgrade applied.")
	# Additional upgrades can be added here
