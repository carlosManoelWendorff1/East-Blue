extends CharacterBody2D

var SPEED = 400.0
var speed_down = 200.0
var has_fish = false
var fish = null
var fish_count = 0.0
var max_weight = 0.0
var curr_weight = 0.0
var rope = null
var rope_lim = 0.0
var weight_test = null
var fish_count_text = null

func format_weight(value: String) -> String:
	return "Weight: " + value + "%"

func format_fish_count(value: String) -> String:
	return "Fish count: " + value

func _ready():
	rope = $"../Rope"
	weight_test = $"../Player/Camera2D/Weight"
	fish_count_text = $"../Player/Camera2D/Fish Count"
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
	
	if position.y < 422 && has_fish:
		has_fish = false
		fish.queue_free()
		curr_weight += fish.weight
		fish_count += 1;
		weight_test.text = format_weight(str((curr_weight / max_weight) * 100).pad_decimals(2))
		fish_count_text.text = format_fish_count(str(fish_count).pad_decimals(2))
		fish = null
		
		if curr_weight > max_weight:
			end_fishing()		
	move_and_slide()
	
func end_fishing():
	PlayerVariables.coins += curr_weight * 1.5
	get_tree().change_scene_to_file("res://scenes/boat.tscn")	
