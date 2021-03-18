extends Node2D

export var dialogTemplate: PackedScene
export var title : String
export var background: Texture
export var defaultLine: String
export var sprite: Texture
export var dialogManager: Script

# Called when the node enters the scene tree for the first time.
func _ready():
	$"TalkingArea".connect("body_entered",self,"on_body_entered_area_talking")
	$"TalkingArea".connect("body_exited",self,"on_body_exited_area_talking")

func on_body_entered_area_talking(body):
	if(body == Global.getPlayer().get_node("kinematicBody")):
		Global.getUiTalking().show()

func on_body_exited_area_talking(body):
	if(body == Global.getPlayer().get_node("kinematicBody")):
		Global.getUiTalking().hide()

func player_launch_dialog():
	return Input.is_action_just_pressed("ui_accept") && $"TalkingArea".overlaps_body(Global.getPlayer().get_node("kinematicBody"))

func launch_dialog():
	var root = get_tree().get_root()
	var node = dialogTemplate.instance()
	Global.saveWorld()
	print_tree_pretty()
	Global.getCustomRoot().remove_child(Global.getWorld())
	root.add_child(node)
	node.get_node("Camera2D").make_current()
	node.set_title(title)
	node.set_background(background)
	node.setDefaultLine(defaultLine)
	node.set_sprite(sprite)
	node.initialize(dialogManager)

func _input(inputEvent):
	if player_launch_dialog():
		launch_dialog()
