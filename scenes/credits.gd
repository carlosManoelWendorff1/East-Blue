extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Control/go_back.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($CanvasLayer/ParallaxBackground/ParallaxLayer2.position > Vector2(0,0)): 
		$CanvasLayer/ParallaxBackground/ParallaxLayer2.position += Vector2(-1,0)
	else:
		$CanvasLayer/ParallaxBackground/ParallaxLayer2.position = Vector2(500,400)
	pass


func _on_go_back_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
	pass # Replace with function body.
