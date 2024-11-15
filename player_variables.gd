extends Node


var coins: int = 120

var day: int = 1

#Upgrade Levels:
var wire_level = 0
var speed_level = 0
var capacity_level = 0
	
func add_coins(value: int) -> void:
	coins += value
	
func get_upgrade(cost: int) -> bool:
	if coins >= cost:
		coins -= cost
		return true
	return false
	
func reset_coins() -> void:
	coins = 0
	
func reset_wire() -> void:
	wire_level = 0
	
func reset_speed() -> void:
	speed_level = 0
	
func reset_capacity() -> void:
	capacity_level = 0
	
func upgrade_wire() -> void:
	if wire_level < 3:
		wire_level += 1
	
func upgrade_speed() -> void:
	if speed_level < 3:
		speed_level += 1
	
func upgrade_capacity() -> void:
	if capacity_level < 3:
		capacity_level += 1