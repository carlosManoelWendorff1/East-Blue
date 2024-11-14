extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Add all wave layers to an array
	var layers = [
		$waves2,
		$waves3,
		$waves4,
		$waves5,
		$waves6,
		$waves7
		# Add more layers here as needed
	]
	
	# Loop through each layer and play animations for each AnimatedSprite2D child
	for layer in layers:
		for child in layer.get_children():
			if child is AnimatedSprite2D:
				child.play()
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
