extends CenterContainer

onready var quit_but = $"VBoxContainer/Button"

# Called when the node enters the scene tree for the first time.
func _ready():
	quit_but.connect("button_up",self,"quit_pressed")

func quit_pressed():
	print_debug("quit pressed")
	get_tree().quit()
