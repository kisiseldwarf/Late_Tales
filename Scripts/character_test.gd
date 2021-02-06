extends "Virtual/ITalkableCharacter.gd"

var tileset = load("res://tileset_test.tres")
var texture = AtlasTexture.new()
var talking : Label
var dialogscene = preload("res://Scenes/Dev/Dialogs/characterdialog_test.tscn")


func _ready():
	# set texture
	var id = tileset.find_tile_by_name("orc_bizarre")
	var tileset_texture = tileset.tile_get_texture(id)
	var tileset_region = tileset.tile_get_region(id)
	
	texture.atlas = tileset_texture
	texture.region = tileset_region
	set_sprite(texture)

func _input(inputEvent):
	if player_launch_dialog():
		changeto_dialog(dialogscene)
