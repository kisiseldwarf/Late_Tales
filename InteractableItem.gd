extends Node2D

export var desc: PoolStringArray
export var logicalElementsName: PoolStringArray
export var textSpeed: float

onready var tween = Global.getUiDesc().get_node("Label/Tween")
var descBuf: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Area2D".connect("body_entered",self,"onAreaEntered")
	$"Area2D".connect("body_exited",self,"onAreaExited")

func onAreaEntered(_node: Node):
	Global.getUiLaunchButDesc().show()

func onAreaExited(_node: Node):
	Global.getUiLaunchButDesc().hide()

func nextLine():
	var label = Global.getUiDesc().get_node("Label")

	if(!descBuf.empty()):
		label.percent_visible = 0
		label.text = descBuf.pop_front()
		tween.interpolate_property(label,"percent_visible",0,1,1)
		tween.start()
	else:
		stopExamine()

func _input(event):
	if(playerLaunchExamine() && Global.getUiDesc().visible == false):
		startExamine()
	else:
		if(event.is_action_pressed("ui_accept") && Global.getUiDesc().visible == true):
			if(!tween.is_active()):
				nextLine()
			else:
				tween.seek(1.0)


func playerLaunchExamine():
	return Input.is_action_just_pressed("ui_accept") && $"Area2D".overlaps_body(Global.getPlayer().get_node("kinematicBody"))

func startExamine():
	Global.deactivatePlayer()
	Global.getUiDesc().show()
	Global.getUiLaunchButDesc().hide()
	descBuf = Array(desc)
	nextLine()

func stopExamine():
	for logicalElementName in logicalElementsName:
		Player.logicalElements.push_back(Player.Logical.new(logicalElementName))
	Global.activatePlayer()
	Global.getUiDesc().hide()
	Global.getUiLaunchButDesc().show()
