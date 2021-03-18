extends Node

func isUiActive() -> bool:
	var ui = get_tree().get_nodes_in_group("ui")[0]
	var uiChildren = ui.get_children()
	for uiChild in uiChildren:
		if(uiChild.is_visible()):
			return true
	return false

func hideAll() -> Array:
	var res: Array = Array()
	var ui = get_tree().get_nodes_in_group("ui")[0]
	var uiChildren = ui.get_children()
	for uiChild in uiChildren:
		if(uiChild.is_visible()):
			res.push_back(uiChild)
		uiChild.hide()
	return res

func show(nodes: Array):
	for node in nodes:
		node.show()

## UI DESC ##

func showUiDesc():
	get_tree().get_nodes_in_group("ui_desc")[0].show()
	Global.getPlayer().set_process(false)

func hideUiDesc():
	get_tree().get_nodes_in_group("ui_desc")[0].hide()
	Global.getPlayer().set_process(true)

func showUiLaunchButDesc():
	if(!isUiActive()):
		get_tree().get_nodes_in_group("ui_desc_launch")[0].show()

func hideUiLaunchButDesc():
	get_tree().get_nodes_in_group("ui_desc_launch")[0].hide()

## UI MAIN MENU ##
var visibleNodeBuffer: Array

func showUiMainMenu():
	visibleNodeBuffer = hideAll()
	get_tree().get_nodes_in_group("ui_main_menu")[0].show()
	Global.getPlayer().set_process(false)

func hideUiMainMenu():
	show(visibleNodeBuffer)
	get_tree().get_nodes_in_group("ui_main_menu")[0].hide()
	Global.getPlayer().set_process(true)

## UI TALKING ##

func showUiTalking():
	if(!isUiActive()):
		get_tree().get_nodes_in_group("ui_talking")[0].show()

func hideUiTalking():
	get_tree().get_nodes_in_group("ui_talking")[0].hide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

