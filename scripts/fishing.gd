extends CharacterBody2D

var hook_speed = 200.0
var fish_in_hook = null
var max_capacity = (PlayerVariables.capacity_level + 1) * 50
var rope_lim = (PlayerVariables.wire_level + 1) * 1500
var used_capacity = 0.0

@onready var rope = $"../Rope"
@onready var weight_test = $"Camera2D/Weight"
@onready var fish_count_text = $"Camera2D/Worth"
@onready var popup = $"Camera2D/Popup"

func format_capacity(value: String) -> String:
	return "Weight: " + value + "%"

func format_worth(value: String) -> String:
	return "Worth: " + value + "$"
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		end_fishing()
		
	var direction := Input.get_axis("ui_up", "ui_down")
	
	if direction:
		if direction == 1 && position.y < rope_lim:
			velocity.y = direction * hook_speed
		elif direction == -1 && position.y > 421:
			if fish_in_hook.on_frenzy:
				popup.new("Stop!")
				velocity.y = -direction * hook_speed * 2
			else:
				velocity.y = direction * hook_speed * 2
		else:
			velocity.y = 0
	else:
		velocity.y = move_toward(velocity.y, 0, hook_speed * 2)
		
	rope.size.y = self.position.y - rope.position.y - (self.get_child(0).texture.get_size().y/2);
	
	if position.y < 422:
		remove_fish()	
	move_and_slide()
	
func end_fishing():
	PlayerVariables.coins += get_weight_price(used_capacity)
	get_tree().change_scene_to_file("res://scenes/boat.tscn")	
	
func add_fish(curr_fish: Node2D):
	if fish_in_hook == null:
		if curr_fish.weight + used_capacity > max_capacity:
			popup.new("Too Heavy!")
			return
		curr_fish.player = self
		curr_fish.caught = true
		curr_fish.velocity.x = 0.0
		fish_in_hook = curr_fish
		
func remove_fish():
	if fish_in_hook != null:
		var fish_value = get_weight_price(fish_in_hook.weight)
		popup.new("+"+str(fish_value).pad_decimals(0)+"$")
		used_capacity += fish_in_hook.weight
		weight_test.text = format_capacity(str((used_capacity / max_capacity) * 100).pad_decimals(2))
		fish_count_text.text = format_worth(str(get_weight_price(used_capacity)).pad_decimals(0))
		fish_in_hook.queue_free()
		fish_in_hook = null

func get_weight_price(weight: float) -> float:
	return weight * 1.5
	
