extends "Virtual/CharacterDialog.gd"

var title = "Kais le con-man"
var time = 0.02

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = ImageTexture.new()
	sprite.load("Assets/ghost.png")
	var bg = ImageTexture.new()
	bg.load("Assets/CYBERPUNK_bg.jpg")
	set_sprite(sprite)
	set_background(bg)
	set_title(title)
	start_lines()
	# can be useful someday bc ui_accept will trigger the button if focus is activated
	# button.enabled_focus_mode = Control.FOCUS_NONE
	add_button("Avez-vous des informations particulieres sur la Rin-Ra ?","rin_ra")
	add_button("Bonjour","no")
	add_button("* Quitter *","quit")

func no():
	$".".remove_child(button_container)
	load_dialog("res://Assets/Dialogs/albin_monologue.tres")
	start_lines()
	yield(self,"dialog_end")
	$".".add_child(button_container)

func rin_ra():
	$".".remove_child(button_container)
	add_line("Ah...")
	add_line("...",0.5)
	add_line("La Rin-Ra... Quels bande d'enfoirés")
	add_line("Je n'ai pas grand chose à dire à leurs sujet...")
	add_line("Après tout, il paraît que même leurs techniques secrètes sont...")
	add_line("...")
	add_line("secrètes.")
	start_lines()
	yield(self,"dialog_end")
	$".".add_child(button_container)

func quit():
	get_tree().change_scene_to(Global.dialog_return_scene)
