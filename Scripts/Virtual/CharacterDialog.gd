extends Node2D

# --- Signals --- #
signal line_end
signal next_line

# --- Sprite --- #
var sprite = Sprite.new()

# --- Text --- #
var textLabel = Label.new()
var textbox_x_size = 500
var textbox_y_size = 150
var theme = Theme.new()
var theme_title = Theme.new()
var font = DynamicFont.new()
var dialog_textbox_offset = 175
var title_textLabel = Label.new()
var titletext_x_size = 500
var titletext_y_size = 50
var writing_dialog = 0
var end_dialog = 0

# --- Background --- #
var background_rect = TextureRect.new()

# --- Foreground --- #
var fg_offset = 125
var blackRect = ColorRect.new()

# --- Buttons --- #
var button_container = VBoxContainer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_background()
	_init_sprite()
	_init_foreground()
	_init_theme()
	_init_text()
	_init_button_container()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# --- Concerning Text --- #

func say(text, time):
	textLabel.text = ""
	var timer = Timer.new()
	writing_dialog = 1
	for chars in text:
		if end_dialog == 1:
			break
		textLabel.text += chars
		yield(get_tree().create_timer(time),"timeout")
	writing_dialog = 0
	emit_signal("line_end")
	textLabel.text = text

func _init_text():
	textLabel.set_size(Vector2(textbox_x_size,textbox_y_size))
	textLabel.set_autowrap(true)
	textLabel.set_clip_text(false)
	textLabel.set_position(get_viewport_rect().size / 2 - Vector2(textLabel.get_size().x/2,0))
	textLabel.set_position(Vector2(textLabel.get_position().x, textLabel.get_position().y + dialog_textbox_offset))
	textLabel.align = HALIGN_LEFT
	$".".add_child(textLabel) 
	_init_title_theme()
	_init_title()
	textLabel.theme = theme

func _init_theme():
	# -- Fonts
	font.font_data = load("res://Assets/Brighton Spring Personal Use Only.ttf")
	font.size = 35
	theme.set_default_font(font)
	# -- Buttons
	theme.set_stylebox("hover","Button",StyleBoxEmpty.new())
	theme.set_stylebox("normal","Button",StyleBoxEmpty.new())
	theme.set_stylebox("pressed","Button",StyleBoxEmpty.new())
	theme.set_stylebox("focus","Button",StyleBoxEmpty.new())
	theme.set_color("font_color","Button",Color(0.7,0.7,0.7,1))
	theme.set_color("font_color_hover","Button",Color(1,1,1,1))
	theme.set_color("font_color_pressed","Button",Color(0.7,0.7,0.7,1))
	theme.set_constant("separation","VBoxContainer",20)
	

func _init_title_theme():
	var font = DynamicFont.new()
	font.font_data = load("res://Assets/Brighton Spring Personal Use Only.ttf")
	font.size = 50
	font.outline_size = 5
	font.outline_color = Color(0,0,0,1)
	theme_title.set_default_font(font)
	title_textLabel.theme = theme_title

func _init_title():
	var offset = 70
	title_textLabel.set_size(Vector2(titletext_x_size,titletext_y_size))
	title_textLabel.set_autowrap(true)
	title_textLabel.set_clip_text(false)
	title_textLabel.align = HALIGN_CENTER
	title_textLabel.set_position(get_viewport_rect().size / 2 - Vector2(textLabel.get_size().x/2,- offset))
	$".".add_child(title_textLabel)

func set_title(title):
	title_textLabel.text = title

# --- Concerning Sprite --- #
func _init_sprite():
	sprite.scale = Vector2(0.5,0.5)
	sprite.position = get_viewport_rect().size / 2
	sprite.name = "sprite"
	$".".add_child(sprite)

func set_sprite(texture):
	$"sprite".texture = texture

# --- Concerning Background --- #
func _init_background():
	background_rect.set_size(Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y/2))
	background_rect.set_position(Vector2(0,0))
	background_rect.set_stretch_mode(TextureRect.STRETCH_KEEP_CENTERED)
	background_rect.name = "background_rect"
	$".".add_child(background_rect,true)

func set_background(texture):
	$"background_rect".set_texture(texture)

# --- Concerning Foreground --- #
func _init_foreground():
	blackRect.color = Color(0,0,0,1)
	blackRect.set_size(Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y/2))
	blackRect.set_position(Vector2(0,get_viewport_rect().size.y/2 + fg_offset))
	$".".add_child(blackRect)

# --- Concerning Input management --- #
func _input(inputEvent):
	if Input.is_action_just_pressed("ui_click"):
		if writing_dialog == 1:
			end_dialog = 1
		elif writing_dialog == 0:
			end_dialog = 0
			emit_signal("next_line")

# --- Concerning Buttons --- #
func _init_button_container():
	var button_container_offsety = 200
	button_container.theme = theme
	button_container.alignment = HALIGN_CENTER
	button_container.set_size(Vector2(300,300))
	button_container.set_position(get_viewport_rect().size/2 - Vector2(button_container.get_size().x/2,-button_container_offsety))
	$".".add_child(button_container)

func add_button(text, method):
	var button = Button.new()
	button.text = text
	button.theme = theme
	button.flat = true
	button.connect("pressed",self,method)
	button_container.add_child(button)
