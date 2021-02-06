extends Control

# --- Signals --- #
signal lines_end

# --- Sprite --- #
onready var sprite = $"character"

# --- Text --- #
onready var textLabel = $"dialogbox"
onready var title_textLabel = $"title"
onready var tween = $"dialogbox/Tween"
var frequency = 1
var writing_dialog = 0
var end_dialog = 0

# --- Background --- #
onready var background_rect = $"background"

# --- Buttons --- #
onready var button_container = $"VBoxContainer"

# --- lines ---#
var line : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# --- Concerning Text --- #

func start_lines():
	writing_dialog = true
	next_line()

func add_line(text,fr=frequency):
	line.push_back([text,fr])

func next_line():
	if !line.empty():
		var data = line.pop_front()
		tween.interpolate_property(textLabel,"percent_visible",0,1,data[1])
		textLabel.percent_visible = 0
		textLabel.text = data[0]
		tween.start()
	else:
		writing_dialog = false
		emit_signal("lines_end")

func set_title(title):
	title_textLabel.text = title

# --- Concerning Sprite --- #
func _init_sprite():
	sprite.position = get_viewport_rect().size / 2

func set_sprite(texture):
	sprite.texture = texture

func set_background(texture):
	background_rect.set_texture(texture)

func is_dialog_finished():
	return line.empty()

# --- Concerning Input management --- #
func _input(inputEvent):
	if Input.is_action_just_pressed("ui_click"):
		if writing_dialog:
			if tween.is_active():
				tween.remove(textLabel,"percent_visible")
				textLabel.percent_visible = 1
			else:
				next_line()
	if Input.is_action_just_pressed("ui_cancel") && !writing_dialog:
		quit()

func add_button(text, method):
	var button = Button.new()
	button.text = text
	button.connect("pressed",self,method)
	button_container.add_child(button)

func quit():
	get_tree().change_scene_to(Global.dialog_return_scene)

## NO CHECK ON THIS FUNCTION BE CAREFUL
func load_dialog(filepath):
	var file = File.new()
	file.open(filepath,File.READ)
	while(!file.eof_reached()):
		var line = file.get_line()
		add_line(line) 
	file.close()
