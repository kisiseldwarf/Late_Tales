extends "ICharacter.gd"

var talking_ui : Label
var player_name = 'Emet'

# Called when the node enters the scene tree for the first time.
func _ready():
	#initializing the theme
	var theme = init_theme()
	
	# creating label 
	talking_ui = create_uidown("'A' to talk",theme)
	$"../HUD".add_child(talking_ui)
	
	# connecting the area of talking
	area_talking.connect("body_entered",self,"on_body_entered_area_talking")
	area_talking.connect("body_exited",self,"on_body_exited_area_talking")

func init_theme():
	return load("res://Assets/Themes/default.theme")

func on_body_entered_area_talking(body):
	if(body == $"../Emet/kinematicbody"):
		talking_ui.show()

func on_body_exited_area_talking(body):
	if(body == $"../Emet/kinematicbody"):
		talking_ui.hide()

# handout func
func player_launch_dialog():
	return Input.is_action_just_pressed("ui_accept") && area_talking.overlaps_body($"../Player/kinematicbody")

func changeto_dialog(dialogscene):
	# saving the current scene
	var cur_scene = PackedScene.new()
	cur_scene.pack(get_tree().current_scene)
	Global.dialog_return_scene = cur_scene
	Global.player_position = $"../Player/kinematicbody".position
	# changing scene
	get_tree().change_scene_to(dialogscene)
