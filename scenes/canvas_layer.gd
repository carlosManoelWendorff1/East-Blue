extends CanvasLayer

var boat_position: Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($ParallaxBackground/moon/moon2.position > Vector2(0,600)): 
		$ParallaxBackground/moon/moon2.position += Vector2(0,0.01)
