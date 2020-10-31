extends Node2D

#preload is better
var menu = preload("../Scenes/menu_princ.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.hotel_song.playing != true):
		Global.hotel_song.play()

func _input(event):
	
	# if the player press escape
	if Input.is_action_just_pressed("ui_cancel"):
		#if the menu is not displayed yet
		if get_node("./HUD/menu_princ") == null:
			var menu_node = menu.instance()
			$"./HUD".add_child(menu_node)
			print_tree()
		#if it is
		else:
			$"./HUD".remove_child($"./HUD/menu_princ")
