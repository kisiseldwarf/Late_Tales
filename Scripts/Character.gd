extends Node2D

var sprite = Sprite.new()
var kinematicbody = KinematicBody2D.new()
var area_talking = Area2D.new()
var ui_down = Label.new()
var uidown_x_size = 1000
var uidown_y_size = 500
var bottom_offset = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_kinematicbody()
	_init_area_talking()
	_init_ui()

# --- Concerning Area of Talking --- #
# This area purpose is to know when the player is close enough
# to a pnj to talk to him by pressing a button

func _init_area_talking():
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(sprite.get_rect().size.x/2+10,sprite.get_rect().size.y/2+10)
	var own_id = area_talking.create_shape_owner(self)
	area_talking.shape_owner_add_shape(own_id,shape)
	area_talking.name = "area"
	$".".add_child(area_talking)

# --- Concerning Sprite --- #

func set_sprite(texture):
	sprite.texture = texture
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(sprite.get_rect().size.x/2,sprite.get_rect().size.y/2)
	kinematicbody.shape_owner_remove_shape(0,0)
	kinematicbody.shape_owner_add_shape(0,shape)

# --- Concerning Kinematicbody --- #

func _init_kinematicbody():
	kinematicbody.name = "kinematicbody"
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(sprite.get_rect().size.x/2,sprite.get_rect().size.y/2)
	var own_id = kinematicbody.create_shape_owner(self)
	kinematicbody.shape_owner_add_shape(own_id,shape)
	$".".add_child(kinematicbody)
	$"kinematicbody".add_child(sprite)

# --- Concerning UI --- #

func create_uidown(text,theme):
	var label = Label.new()
	label.set_size(Vector2(uidown_x_size,uidown_y_size))
	label.set_autowrap(true)
	label.theme = theme
	label.align = HALIGN_CENTER
	label.set_anchors_and_margins_preset(Control.PRESET_CENTER_BOTTOM, Control.PRESET_MODE_KEEP_WIDTH,bottom_offset)
	label.hide()
	label.text = text
	return label

func _init_ui():
	var InitTheme = load("Scripts/InitTheme.gd")
	var theme = Theme.new()
	var font = DynamicFont.new()
	var theme_initializator = InitTheme.new()
	theme_initializator.init_theme(theme, font)
	theme.default_font.outline_size = 2
	theme.default_font.outline_color = Color(0,0,0,1)
	theme.default_font.size = 50
	ui_down.set_size(Vector2(uidown_x_size,uidown_y_size))
	ui_down.set_autowrap(true)
	ui_down.theme = theme
	ui_down.align = HALIGN_CENTER
	ui_down.set_anchors_and_margins_preset(Control.PRESET_CENTER_BOTTOM, Control.PRESET_MODE_KEEP_WIDTH,30)
	ui_down.hide()

func set_uidown_text(name):
	ui_down.text = name
