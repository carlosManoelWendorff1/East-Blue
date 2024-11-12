extends Node2D

signal close_dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	emit_signal("close_dialog")
	$CanvasLayer.hide()
	pass # Replace with function body.
