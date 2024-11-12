extends CharacterBody2D

# Constants for speed, acceleration, and jump velocity
var speed = 300.0
const MAX_SPEED = 300.0
var acceleration = 200.0
const JUMP_VELOCITY = -400.0

# Define the set_speed signal

func _ready():
	$"../BottleNewWorld".connect("open_dialog", stop_player)
	$"../BottleNewWorld/Message".connect("close_dialog", release_player)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		# Accelerate towards the max speed
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, acceleration * delta)
	else:
		# Decelerate to a stop
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)
	move_and_slide()

func stop_player() -> void:
	print("stop_player")
	self.speed = 0
	self.acceleration = 0  # Set acceleration to 0 to prevent movement

func release_player() -> void:
	print("release_player")
	self.speed = 300
	self.acceleration = 200  # Reset acceleration for normal movement

# Function to handle the speed change
func set_speed(new_speed):
	speed = new_speed
	print("Speed set to:", speed)
