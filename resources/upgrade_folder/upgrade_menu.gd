class_name UpgradeMenu
extends Control

@onready var button: Button = $MarginContainer/VBoxContainer/Button

@export var upgrade_option_array : Array[UpgradeOption] = []

@export var available_upgrades : Array[BaseUpgrade] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.grab_focus()
	select_upgrades()

func select_upgrades() -> void:
	for i in upgrade_option_array.size():
		upgrade_option_array[i].set_upgrade_option(available_upgrades[i])


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/boat.tscn")
