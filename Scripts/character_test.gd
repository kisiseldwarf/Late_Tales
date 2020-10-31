extends "Character.gd"

var tileset = load("res://tileset_test.tres")
var texture = AtlasTexture.new()
var talking : Label

func _ready():
	var id = tileset.find_tile_by_name("orc_bizarre")
	var tileset_texture = tileset.tile_get_texture(id)
	var tileset_region = tileset.tile_get_region(id)
	
	texture.atlas = tileset_texture
	texture.region = tileset_region
	set_sprite(texture)
	
	area_talking.connect("body_entered",self,"on_body_entered_area_talking")
	area_talking.connect("body_exited",self,"on_body_exited_area_talking")
	
	set_uidown_text("Press X to talk to Georgia")
	$"../HUD".add_child(ui_down)
	
	var InitTheme = load("Scripts/InitTheme.gd")
	var theme = Theme.new()
	var font = DynamicFont.new()
	var theme_initializator = InitTheme.new()
	theme_initializator.init_theme(theme, font)
	theme.default_font.outline_size = 2
	theme.default_font.outline_color = Color(0,0,0,1)
	theme.default_font.size = 50
	
	talking = create_uidown("'A' to talk",theme)
	$"../HUD".add_child(talking)

func _input(inputEvent):
	if Input.is_action_just_pressed("ui_accept") && area_talking.overlaps_body($"../Player/kinematicbody"):
		# saving scene state
		var act_scene = PackedScene.new()
		act_scene.pack(get_tree().current_scene)
		Global.dialog_return_scene = act_scene
		Global.player_position = $"../Player/kinematicbody".position
		# changing scene
		get_tree().change_scene("res://Scenes/characterdialog_test.tscn")

# --- Concerning Areas --- #

func on_body_entered_area_talking(body):
	if(body == $"../Player/kinematicbody"):
		talking.show()

func on_body_exited_area_talking(body):
	if(body == $"../Player/kinematicbody"):
		talking.hide()
