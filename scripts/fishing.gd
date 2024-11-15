extends CharacterBody2D

var SPEED = PlayerVariables.speed_level * 2.0
var speed_down = PlayerVariables.speed_level
var has_fish = false
var fish = null
var fish_count = 0
var max_weight = PlayerVariables.capacity_level
var curr_weight = 0.0
var rope = null
var rope_lim = PlayerVariables.wire_level
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
	if max_weight == 0:
		max_weight = 10.0
	if rope_lim == 0:
		rope_lim = 1500.0
	if SPEED == 0:
		SPEED = 400.0
	if speed_down == 0:
		speed_down = 200.0
	
	
func _physics_process(delta: float) -> void:
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
			get_tree().change_scene_to_file("res://scenes/boat.tscn")

		
	move_and_slide()
