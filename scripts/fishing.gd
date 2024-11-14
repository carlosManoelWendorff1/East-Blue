extends CharacterBody2D

const SPEED = 200.0
var has_fish = false
var fish = null
var fish_count = 0;
var rope = null

func _ready():
	rope = $"../Rope"
	

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_up", "ui_down")
	if direction:
		if position.y > 421 || direction == 1:
			velocity.y = direction * SPEED
			
		else:
			velocity.y = 0
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	rope.size.y = self.position.y - rope.position.y - (self.get_child(0).texture.get_size().y/2);
	
	if position.y < 422 && has_fish:
		has_fish = false
		fish.queue_free()
		fish = null
		fish_count += 1;
		

		
	move_and_slide()
