extends Node2D

#preload is better
var menu = preload("res://Scenes/Prefabs/menu_princ.tscn")
export var music : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.setAudioStream(music)
	Global.playAudio($".")

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		#if the menu is not displayed yet
		if get_node("./HUD/menu_princ") == null:
			var menu_node = menu.instance()
			$"./HUD".add_child(menu_node)
		else:
			$"./HUD".remove_child($"./HUD/menu_princ")
