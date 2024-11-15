extends CharacterBody2D

var SPEED = 400.0
var speed_down = 200.0
var has_fish = false
var fish = null
var max_weight = 0.0
var curr_weight = 0.0
var rope = null
var rope_lim = 0.0
var weight_test = null
var fish_count_text = null
@onready var popup = $"Camera2D/Popup"

func format_weight(value: String) -> String:
	return "Weight: " + value + "%"

func format_fish_count(value: String) -> String:
	return "Worth: " + value + "$"

func _ready():
	rope = $"../Rope"
	weight_test = $"../Player/Camera2D/Weight"
	fish_count_text = $"../Player/Camera2D/Worth"
	rope_lim = (PlayerVariables.wire_level + 1) * 1500
	max_weight = (PlayerVariables.capacity_level + 1) * 30
	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		end_fishing()
		
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		if direction == 1 && position.y < rope_lim:
			velocity.y = direction * speed_down
		elif direction == -1 && position.y > 421:
			velocity.y = direction * SPEED
			
		else:
			velocity.y = 0
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	rope.size.y = self.position.y - rope.position.y - (self.get_child(0).texture.get_size().y/2);
	
	if position.y < 422:
		remove_fish()
		
		if curr_weight > max_weight:
			end_fishing()		
	move_and_slide()
	
func end_fishing():
	PlayerVariables.coins += curr_weight * 1.5
	get_tree().change_scene_to_file("res://scenes/boat.tscn")	
	
func add_fish(curr_fish: Node2D):
	if not has_fish:
		if curr_fish.weight + curr_weight > max_weight:
			popup.new("Too Heavy!")
			return
		curr_fish.player = self
		curr_fish.caught = true
		curr_fish.velocity.x = 0.0
		has_fish = true
		fish = curr_fish
		
func remove_fish():
	if has_fish:
		var fish_value = fish.weight * 1.5
		popup.new("+"+str(fish_value).pad_decimals(0)+"$")
		has_fish = false
		curr_weight += fish.weight
		weight_test.text = format_weight(str((curr_weight / max_weight) * 100).pad_decimals(2))
		fish_count_text.text = format_fish_count(str(curr_weight * 1.5).pad_decimals(0))
		fish.queue_free()
		fish = null
