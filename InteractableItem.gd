extends Node2D

export var desc: PoolStringArray
export var logicalElementsId: PoolIntArray
export var textSpeed: float

onready var tween = Global.getUiDesc().get_node("Label/Tween")
var descBuf: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Area2D".connect("body_entered",self,"onAreaEntered")
	$"Area2D".connect("body_exited",self,"onAreaExited")

func onAreaEntered(_node: Node):
	Ui.showUiLaunchButDesc()

func onAreaExited(_node: Node):
	Ui.hideUiLaunchButDesc()

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
	Ui.showUiDesc()
	Ui.hideUiLaunchButDesc()
	descBuf = Array(desc)
	nextLine()

func stopExamine():
	for logicalElementId in logicalElementsId:
		Global.db.query("SELECT * FROM logicals WHERE id="+str(logicalElementId))
		var logicalElement = Global.db.query_result[0]
		var res = Global.db.query("SELECT * FROM logical_links WHERE idFirst="+str(logicalElement["id"])+" OR idSecond="+str(logicalElement["id"]))
		print(res)
		print(Global.db.query_result)
		var logicalElementLinks = Global.db.query_result
		Player.logicalElements.push_back(Player.toLogical(logicalElement, logicalElementLinks))
	Ui.hideUiDesc()
	Ui.showUiLaunchButDesc()
