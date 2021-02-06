extends Node2D

var dialog_return_scene : PackedScene
var player_position = null
var hotel_song = AudioStreamPlayer2D.new()
var scenepath = "user://return.tscn"
var gamename = "Late Hotel Stories"
var savepath = "user://save.lhs"
const encryptionkey : String = "k0a210eBbp"

# Called when the node enters the scene tree for the first time.
func _ready():
	hotel_song.stream = load("Assets/godot.wav")
	hotel_song.attenuation = 0
	$".".add_child(hotel_song)

func state():
	var state = {
		"player_position":player_position,
		"dialog_return_scene":scenepath,
	}
	return JSON.print(state)

func save():
	var file = File.new()
	file.open_encrypted_with_pass(savepath,File.WRITE,encryptionkey)
	var jsonsave = state()
	file.store_string(jsonsave)
	file.close()

func _load():
	var file = File.new()
	file.open_encrypted_with_pass(savepath,File.READ,encryptionkey)
	var result = JSON.parse(file.get_as_text())
	var dico = result.result
	player_position = dico["player_position"]
	dialog_return_scene = load(dico["dialog_return_scene"])
