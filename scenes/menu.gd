extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"CanvasLayer/Control/VBoxContainer/Start Game".grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($CanvasLayer/ParallaxBackground/ParallaxLayer2.position > Vector2(0,0)): 
		$CanvasLayer/ParallaxBackground/ParallaxLayer2.position += Vector2(-1,0)
	else:
		$CanvasLayer/ParallaxBackground/ParallaxLayer2.position = Vector2(1000,400)
	
	pass


func _on_start_game_button_down() -> void:
	print("começou")
	get_tree().change_scene_to_file("res://scenes/boat.tscn")
	pass # Replace with function body.


func _on_options_button_down() -> void:
	pass # Replace with function body.


func _on_credits_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	pass # Replace with function body.


func _on_quit_game_button_down() -> void:
	print("cabou")
	get_tree().quit()
	pass # Replace with function body.
