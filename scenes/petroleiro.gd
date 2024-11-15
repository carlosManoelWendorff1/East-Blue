extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($Sprite2D/Area2D.has_overlapping_bodies()):
		$RichTextLabel.show()
		$RichTextLabel2.show()
	else:
		$RichTextLabel.hide()
		$RichTextLabel2.hide()
	
	if($Sprite2D/Area2D.has_overlapping_bodies() and Input.is_action_just_released("ui_accept")):
		PlayerVariables.day += 1
		get_tree().change_scene_to_file("res://scenes/upgrades.tscn")
		
	pass
