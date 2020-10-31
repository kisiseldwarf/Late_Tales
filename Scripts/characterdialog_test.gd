extends "CharacterDialogScene.gd"

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
	say("Salut Mae, tranquille ?",0)
	# can be useful someday bc ui_accept will trigger the button if focus is activated
	# button.enabled_focus_mode = Control.FOCUS_NONE
	add_button("Moi ca va","debug")
	add_button("Je bois un cafe","debug")
	add_button("Quelle vie","rin_ra")
	add_button("* Quitter *","quit")

func rin_ra():
	$".".remove_child(button_container)
	say("Ah...",time)
	yield(self, "next_line")
	say("...",0.5)
	yield(self,"next_line")
	say("La Rin-Ra... Quels bande d'enfoirés",time)
	yield(self, "next_line")
	say("Je n'ai pas grand chose à dire à leurs sujet...",time)
	yield(self, "next_line")
	say("Après tout, il paraît que même leurs techniques secrètes sont...",time)
	yield(self,"next_line")
	say("...",time)
	yield(self,"next_line")
	say("secrètes.",time)
	yield(self,"line_end")
	$".".add_child(button_container)

func debug():
	# removing the container temporarily is one way to solve the ui_accept triggering
	# the buttons infinitely
	$".".remove_child(button_container)
	say("Bonjour, j'aime pas Kais car il est gros",time)
	yield(self, "next_line")
	say("Mais bon, il faut croire que tu es assez debile",time)
	yield(self, "next_line")
	say("Alors approche...",time)
	yield(self, "next_line")
	say("Alors quoi ? On a peur j'imagine ?!",time)
	yield(self,"line_end")
	$".".add_child(button_container)

func quit():
	get_tree().change_scene_to(Global.dialog_return_scene)
