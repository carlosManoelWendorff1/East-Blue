extends CharacterBody2D

const SPEED = 200.0
var fish_speed = 200.0
var caught = false

func _physics_process(delta: float) -> void:
	if caught:
		var direction := Input.get_axis("ui_up", "ui_down")
		if direction:
			velocity.y = direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			
		move_and_slide()
		
	if not caught:
		velocity.x = fish_speed
		move_and_slide()


func on_collision(body: Node2D):	
	if body.is_in_group("player") && not body.has_fish:
		caught = true
		velocity.x = 0.0
		body.has_fish = true
		body.fish = self
	elif body.is_in_group("wall"):
		fish_speed = -fish_speed;		
