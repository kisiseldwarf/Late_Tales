extends Node2D

var dialog_return_scene : PackedScene
var player_position = null
var audioPlayer: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var scenepath = "user://return.tscn"
var gamename = "Late Hotel Stories"
var savepath = "user://save.lhs"
var playerName : String = "Emet"
const encryptionkey : String = "k0a210eBbp"

func setAudioStream(audioStream: AudioStream):
	audioPlayer.stream = audioStream

func playAudio(node: Node):
	node.add_child(audioPlayer)
	audioPlayer.play()

func state() -> String:
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

func getPlayer() -> Node:
	return get_tree().get_nodes_in_group("player")[0]

func _load():
	var file = File.new()
	file.open_encrypted_with_pass(savepath,File.READ,encryptionkey)
	var result = JSON.parse(file.get_as_text())
	var dico = result.result
	player_position = dico["player_position"]
	dialog_return_scene = load(dico["dialog_return_scene"])
