extends CharacterBody2D

const SPEED = 400.0
const speed_down = 200.0
var fish_speed = 200.0
var caught = false
var player = null
var sprite = null
var fish_multiplier = 1
var weight = 0

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	sprite = self.get_child(0)
	var fish_skin = rng.randf_range(0, 3)
	fish_multiplier = rng.randf_range(1, 1+(position.y-400)/300)
	if fish_skin < 1:
		sprite.play("default")
	elif fish_skin < 2:
		sprite.play("fish2")
	elif fish_skin < 3:
		sprite.play("fish3")
	self.scale.x = fish_multiplier
	self.scale.y = fish_multiplier
	weight = fish_multiplier * 5
	

func _physics_process(delta: float) -> void:
	if caught:
		sprite.stop()
		sprite.flip_v = true
		position.y = player.position.y
		position.x = player.position.x
		move_and_slide()
		
	if not caught:
		velocity.x = fish_speed
		move_and_slide()

	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false


func on_collision(body: Node2D):	
	if body.is_in_group("player") && not body.has_fish && weight + body.curr_weight <= body.max_weight:
		player = body
		caught = true
		velocity.x = 0.0
		body.has_fish = true
		body.fish = self
	elif body.is_in_group("wall"):
		fish_speed = -fish_speed;		
