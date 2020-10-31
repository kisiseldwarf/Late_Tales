extends Node2D

var dialog_return_scene : PackedScene
var player_position = null
var hotel_song = AudioStreamPlayer2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	hotel_song.stream = load("Assets/godot.wav")
	hotel_song.attenuation = 0
	$".".add_child(hotel_song)
