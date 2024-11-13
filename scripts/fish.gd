extends CharacterBody2D

const SPEED = 100.0
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
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index)
			
			if collision == null:
				return
				
			var coll = collision.get_collider()
			
			if coll.is_in_group("player"):
				caught = true
				velocity.x = 0.0;
			elif coll.is_in_group("wall"):
				fish_speed = -fish_speed
				
