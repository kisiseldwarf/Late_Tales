extends CenterContainer

onready var quit_but = $"VBoxContainer/Quit"
onready var save_but = $"VBoxContainer/Save"

# Called when the node enters the scene tree for the first time.
func _ready():
	quit_but.connect("button_up",self,"quit_pressed")
	save_but.connect("button_up",self,"save_pressed")

func quit_pressed():
	get_tree().quit()

func save_pressed():
	Global.player_position = Global.getPlayer().get_node("kinematicBody").position
	var act_scene = PackedScene.new()
	act_scene.pack(get_tree().current_scene)
	ResourceSaver.save("user://return.tscn",act_scene)
	Global.save()