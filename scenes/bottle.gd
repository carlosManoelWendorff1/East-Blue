extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Call this function to emit the set_speed signal
func set_speed(new_speed):
	emit_signal("set_speed", new_speed)
