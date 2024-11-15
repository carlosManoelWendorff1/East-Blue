extends CharacterBody2D

var modifier = PlayerVariables.speed_level + 1

# Constants for speed and acceleration
var speed = 0.0
var MAX_SPEED = 100.0 * modifier
var ACCELERATION = 50.0 * modifier
const DECELERATION = 100.0

# Direction tracking variables
var facing_right = true
var target_scale_x = 1.0  # Target scale based on facing direction
const FLIP_DURATION = 0.2  # Duration of the flip in seconds
var flip_time = 0.0  # Time elapsed during the flip

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		speed = move_toward(speed, direction * MAX_SPEED, ACCELERATION * delta)

		# Trigger flip if direction changes
		if (direction > 0 and not facing_right) or (direction < 0 and facing_right):
			facing_right = not facing_right
			target_scale_x = 1.0 if facing_right else -1.0
			flip_time = FLIP_DURATION  # Start the flip effect
	else:
		speed = move_toward(speed, 0, DECELERATION * delta)

	# Gradually update the sprite scale during the flip
	if flip_time > 0:
		flip_time -= delta
		# Interpolate scale.x smoothly towards the target value
		$boat_sprite.scale.x = lerp($boat_sprite.scale.x, target_scale_x, delta / FLIP_DURATION)

	velocity.x = speed
	move_and_slide()
