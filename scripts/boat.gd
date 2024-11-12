extends CharacterBody2D

# Constants for speed and jump velocity
var speed = 300.0
const JUMP_VELOCITY = -400.0

# Define the set_speed signal

func _ready():
	$"../BottleNewWorld".connect("open_dialog",stop_player)
	$"../BottleNewWorld/Message".connect("close_dialog",release_player)
	pass
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
	move_and_slide()
	
func stop_player() -> void:
	print("stop_player")
	self.speed = 0
	
func release_player() -> void:
	print("release_player")
	self.speed = 300
	
# Function to handle the speed change
func set_speed(new_speed):
	speed = new_speed
	print("Speed set to:", speed)
