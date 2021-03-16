extends Node2D

var dialog_return_scene : PackedScene
var player_position = null
var audioPlayer: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var scenepath = "user://return.tscn"
var gamename = "Late Hotel Stories"
var savepath = "user://save.lhs"
const encryptionkey : String = "k0a210eBbp"
var dialogStates: Dictionary = {}
var world: Node2D
var uiMode: bool = false

func activateUiMode():
	uiMode = true

func deactivateUiMode():
	uiMode = false

func isUiMode():
	return uiMode

func setAudioStream(audioStream: AudioStream):
	audioPlayer.stream = audioStream

func playAudio(node: Node):
	node.add_child(audioPlayer)
	audioPlayer.play()

func state() -> String:
	var state = {
		"player_position":player_position,
		"dialog_return_scene":scenepath,
		"dialogStates": dialogStates
	}
	return JSON.print(state)

func save():
	var file = File.new()
	file.open_encrypted_with_pass(savepath,File.WRITE,encryptionkey)
	var jsonsave = state()
	file.store_string(jsonsave)
	file.close()

func saveWorld():
	world = getWorld()

func getCustomRoot() -> Node:
	return get_tree().get_root().get_child(1)

func getMainCamera() -> Camera2D:
	return get_tree().get_nodes_in_group("main_camera")[0] as Camera2D

func getPlayer() -> Node:
	return get_tree().get_nodes_in_group("player")[0]

func getUiDesc() -> Node:
	return get_tree().get_nodes_in_group("ui_desc")[0]

func getUiLaunchButDesc() -> Node:
	return get_tree().get_nodes_in_group("ui_desc_launch")[0]

func getUiTalking() -> Node:
	return get_tree().get_nodes_in_group("ui_talking")[0]

func getUiMainMenu() -> Node:
	return get_tree().get_nodes_in_group("ui_main_menu")[0]

func getWorld() -> Node:
	return get_tree().get_nodes_in_group("world")[0]

func activatePlayer():
	getPlayer().set_process(true)

func deactivatePlayer():
	getPlayer().set_process(false)

func _load():
	var file = File.new()
	file.open_encrypted_with_pass(savepath,File.READ,encryptionkey)
	var result = JSON.parse(file.get_as_text())
	var dico = result.result
	player_position = dico["player_position"]
	dialog_return_scene = load(dico["dialog_return_scene"])
