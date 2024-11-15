extends CharacterBody2D

var modifier = PlayerVariables.speed_level + 1

# Constants for speed and acceleration
var speed = 0.0
var MAX_SPEED = 100.0 * modifier
var ACCELERATION = 50.0 * modifier
const DECELERATION = 100.0

# Direction tracking variables
var facing_right = true
@onready var engine_sound = $AudioStreamPlayer2D # Reference to the AudioStreamPlayer node
@onready var intro_sound = $AudioStreamPlayer2D2 # Reference to the intro AudioStreamPlayer node

# Flag to track if intro sound has played
var intro_played = false

func _ready():
	# Play the intro sound once
	if not intro_played:
		intro_sound.play()
		intro_played = true

		# Connect the signal to start the engine sound once the intro finishes
		intro_sound.connect("finished", _on_intro_finished)

func _on_intro_finished():
	# Once the intro song finishes, play the engine sound
	engine_sound.play()

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		# Move the boat
		speed = move_toward(speed, direction * MAX_SPEED, ACCELERATION * delta)

		# Flip the sprite if the direction changes
		if (direction > 0 and not facing_right) or (direction < 0 and facing_right):
			facing_right = not facing_right
			# Flip the sprite by changing scale.x
			$boat_sprite.scale.x = 5 if facing_right else -5
	else:
		speed = move_toward(speed, 0, DECELERATION * delta)

	# Apply movement
	velocity.x = speed
	move_and_slide()

	# Update the engine sound based on speed
	update_engine_sound()

func update_engine_sound():
	# Use the absolute value of speed to calculate pitch and volume
	var abs_speed = abs(speed)

	# Adjust pitch based on the absolute speed
	var pitch = 1.0 + (abs_speed / MAX_SPEED) * 0.5  # Adjust pitch based on speed
	engine_sound.pitch_scale = pitch

	# Optionally, adjust volume based on speed (optional)
	var volume = -10 + (abs_speed / MAX_SPEED) * 10  # Volume between -10 dB (idle) and 0 dB (full speed)
	engine_sound.volume_db = volume
