extends Node2D

var velocity = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	$"kinematicBody/AnimatedSprite".play('idle')
	if(Global.player_position != null):
		$"kinematicBody".position = Global.player_position

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
	$"kinematicBody".move_and_slide(movement)
