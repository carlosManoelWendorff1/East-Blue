extends Control

@export var time_scale = 60
@onready var clock_label = $clock_label
@onready var timer = $time_timer

var game_time = { "hour": 18, "minute": 0 }

func _ready():
	timer.timeout.connect(update_game_time)

func update_game_time():
	game_time["minute"] += time_scale / 60 

	if game_time["minute"] >= 60:
		game_time["hour"] += int(game_time["minute"] / 60)
		game_time["minute"] %= 60

	if game_time["hour"] >= 24:
		game_time["hour"] %= 24

	var formatted_time = "%02d:%02d" % [game_time["hour"], game_time["minute"]]
	clock_label.text = formatted_time
