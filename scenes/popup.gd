extends Control

@onready var timer = $"Timer"
@onready var message = $"Message"

# Called when the node enters the scene tree for the first time.
func new(text: String) -> void:
	if timer.is_stopped():
		message.text = text
		timer.start()

func timer_callback():
	message.text = ""
