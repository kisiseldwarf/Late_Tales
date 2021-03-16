extends Control

# --- Signals --- #
signal lines_end

# --- Sprite --- #
onready var sprite = $"character"

# --- Text --- #
onready var textLabel: Label = $"dialogbox"
onready var title_textLabel: Label = $"title"
onready var tween = $"dialogbox/Tween"
onready var audio = $"AudioStreamPlayer2D"
var frequency = 1

# --- Background --- #
onready var background_rect = $"background"

# --- Buttons --- #
onready var button_container = $"VBoxContainer"

# --- lines ---#
var bufLine : Array
var dialogLines: Dictionary
var bufChar: Array
var actualLine;

func _ready():
	if(audio.stream == null):
		#put an empty sound in it
		pass

# --- Concerning Text --- #

func add_line(text,fr=frequency):
	bufLine.push_back([text,fr])

func speakingAnimation(bufChar: Array):
	textLabel.text += bufChar.pop_front()
	if(bufChar.empty()):
		tween.stop_all()

func stringToArray(text: String) -> Array:
	var res: Array
	for c in text:
		res.append(c)
	return res

func arrayToString(array: Array) -> String:
	var res: String
	for c in array:
		res += c
	return res

func next_line():
	if !bufLine.empty():
		textLabel.text = ""
		actualLine = bufLine.pop_front()
		#bufChar = stringToArray(actualLine[0])
		tween.interpolate_property(textLabel,"percent_visible", 0, 1, actualLine[1])
		#tween.interpolate_callback(self, 0.01, "speakingAnimation", bufChar)
		#tween.repeat = true
		textLabel.text = actualLine[0]
		tween.start()
	else:
		emit_signal("lines_end")

func set_title(title):
	title_textLabel.text = title

func set_sprite(texture):
	sprite.texture = texture

func set_background(texture):
	background_rect.set_texture(texture)

func setDefaultLine(text: String):
	add_line(text)

# --- Concerning Input management --- #
func _input(_inputEvent):
	if Input.is_action_just_pressed("ui_click"):
		if tween.is_active():
			tween.stop_all()
			textLabel.percent_visible = 1
			bufChar.clear()
		else:
			next_line()
			
	if Input.is_action_just_pressed("ui_cancel"):
		Global.getCustomRoot().add_child(Global.world)
		Global.getMainCamera().make_current()
		queue_free()

func dialogButtonHandler(lines: PoolStringArray, button: Button):
	startTalking()
	
	if(!Global.dialogStates.has("dialBut-"+String(hash(lines)))):
		Global.dialogStates["dialBut-"+String(hash(lines))] = true
		button.text += "GREYED"
	for line in lines:
		add_line(line)
	next_line()
	
	yield(self, "lines_end")
	stopTalking()

func add_button(text, lines: PoolStringArray):
	var button = Button.new()
	button.text = text
	if(Global.dialogStates.has("dialBut-"+String(hash(lines)))):
		button.text += "GREYED"
	button.connect("pressed",self,"dialogButtonHandler",[lines, button])
	button_container.add_child(button)

func startTalking():
	$".".remove_child(button_container)

func stopTalking():
	$".".add_child(button_container)

func initialize(dialogManager: Script):
	var dialogManagerInstance = dialogManager.new()
	dialogManagerInstance.inflate(self)

## NO CHECK ON THIS FUNCTION BE CAREFUL
func loadDialogUnsafe(filepath) -> PoolStringArray:
	var file = File.new()
	file.open(filepath,File.READ)
	var res = []
	while(!file.eof_reached()):
		var line = file.get_line()
		res.push_back(line) 
	file.close()
	return res

func setVoice(stream: AudioStream):
	audio.stream = stream

