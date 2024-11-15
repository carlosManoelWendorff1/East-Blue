class_name UpgradeOption
extends Control


@export var base_null_upgrade : BaseUpgrade = null
@onready var upgrade_label: Label = $Panel/MarginContainer/VBoxContainer/UpgradeLabel
@onready var texture_bar: TextureProgressBar = $Panel/MarginContainer/VBoxContainer/HBoxContainer/TextureBar
@onready var stats_label: Label = $Panel/MarginContainer/VBoxContainer/HBoxContainer/StatsLabel
@onready var desc_label: Label = $Panel/MarginContainer/VBoxContainer/ScrollContainer/DescriptionLabel
@onready var button: Button = $Panel/MarginContainer/VBoxContainer/Button

var baseUpgrade: BaseUpgrade

var initial_price: int = 0
var price_of_upgrade: int = 0

var upgrade_key: String = ""
var upgrade_value: int = 0

var upgrade_method: Callable

func _ready():
	set_upgrade_option(null)
	
func set_upgrade_option(upgrade: BaseUpgrade) -> void:
	if upgrade == null:
		upgrade_label.text = base_null_upgrade.upgrade_name
		desc_label.text = base_null_upgrade.upgrade_description
		button.text = "Buy(" + str(base_null_upgrade.upgrade_cost) + ")"
		stats_label.text = "Status:\n" + str(base_null_upgrade.upgrade_initial + (base_null_upgrade.upgrade_value * upgrade_value)) + base_null_upgrade.upgrade_measure
	else:
		baseUpgrade = upgrade
		upgrade_key = upgrade.upgrade_key
		get_upgrade_name(upgrade.upgrade_key)
		upgrade_label.text = upgrade.upgrade_name
		desc_label.text = upgrade.upgrade_description
		button.text = "Buy(" + str(upgrade.upgrade_cost) + ")"
		stats_label.text = "Status:\n" + str(upgrade.upgrade_initial + (upgrade.upgrade_value * upgrade_value)) + upgrade.upgrade_measure
		initial_price = upgrade.upgrade_cost
		price_of_upgrade = upgrade.upgrade_cost
		_update_upgrade()

func get_upgrade_name(name: String) -> void:
	if name == "wire":
		upgrade_value = PlayerVariables.wire_level
		upgrade_method = PlayerVariables.upgrade_wire
	if name == "capacity":
		upgrade_value = PlayerVariables.capacity_level
		upgrade_method = PlayerVariables.upgrade_capacity
	if name == "speed":
		upgrade_value = PlayerVariables.speed_level
		upgrade_method = PlayerVariables.upgrade_speed
	

func _on_button_button_down() -> void:
	if upgrade_value < 3:
		if PlayerVariables.get_upgrade(price_of_upgrade):
			upgrade_method.call()
			get_upgrade_name(upgrade_key)
			_update_upgrade()
		else:
			button.text = "Dinheiro insuficiente"
			await get_tree().create_timer(3).timeout
			_update_upgrade()

func _update_upgrade() -> void: 
	texture_bar.value = upgrade_value
	price_of_upgrade = initial_price * (pow(2, upgrade_value))
	if upgrade_value == 3:
		button.hide()
	button.text = "Buy(" + str(price_of_upgrade) + ")"
	stats_label.text = "Status:\n" + str(baseUpgrade.upgrade_initial + (baseUpgrade.upgrade_value * upgrade_value)) + baseUpgrade.upgrade_measure
		
