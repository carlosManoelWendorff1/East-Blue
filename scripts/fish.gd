extends CharacterBody2D

const SPEED = 100.0
var player_speed = 0.0;
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
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index)
			
			if collision == null:
				return
				
			if collision.get_collider().is_in_group("player"):
				caught = true
				
