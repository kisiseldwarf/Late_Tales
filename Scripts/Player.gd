extends Node2D

var sprite = AnimatedSprite.new()
var tileset = load("tileset_test.tres")
var texture : AtlasTexture = AtlasTexture.new()
var kinematicbody = KinematicBody2D.new()
var velocity = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	$"kinematicbody/AnimatedSprite".play('idle')
	if(Global.player_position != null):
		$"kinematicbody".position = Global.player_position

# --- Movement --- #
# ( might try to make it work in _input )
func _process(delta):
	var direction = Vector2(0,0)
	if Input.is_action_pressed("ui_left"):
		direction =+ Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1,0)
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0,1)
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0,-1)
	
	var movement = direction.normalized() * velocity
	$"kinematicbody".move_and_slide(movement)
