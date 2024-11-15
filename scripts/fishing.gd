extends CharacterBody2D

const SPEED = 400.00
const speed_down = 200.0
var has_fish = false
var fish = null
var fish_count = 0
var max_weight = 100.0
var curr_weight = 0.0
var rope = null
var rope_lim = 5800
var weight_test = null

func format_weight(value: String) -> String:
	return "Weight: " + value + "%"

func _ready():
	rope = $"../Rope"
	weight_test = $"../Player/Camera2D/Weight"
	
	
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_up", "ui_down")
	print(position.y)
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
		weight_test.text = format_weight(str((curr_weight / max_weight) * 100).pad_decimals(2))
		fish = null
		fish_count += 1;
		
	move_and_slide()
