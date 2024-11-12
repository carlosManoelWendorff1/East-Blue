extends CharacterBody2D

const SPEED = 100.0
const caught = false

func _physics_process(delta: float) -> void:
	if caught:
		var direction := Input.get_axis("ui_up", "ui_down")
		if direction:
			velocity.y = direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()
