extends Node2D
signal open_dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Bottle6/Message".connect("close_dialog",delete_bottle)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Close dialog function when triggered
func close_dialog() -> void:
	print("Dialog closed.")
	$Message.hide()  # Optionally hide the message when closing it.

# Function that shows the dialog and sets focus to the button
func _on_area_2d_body_entered(body: Node2D) -> void:
	emit_signal("open_dialog")
	print("Entered area")
	# Show the dialog
	$Message/CanvasLayer.show()
	pass
	
func delete_bottle() -> void:
	$".".hide()
	$Area2D.monitoring = false	
