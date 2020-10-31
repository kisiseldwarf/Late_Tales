extends Node2D

var sprite = AnimatedSprite.new()
var tileset = load("tileset_test.tres")
var texture : AtlasTexture = AtlasTexture.new()
var kinematicbody = KinematicBody2D.new()
var velocity = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	kinematicbody.name = "kinematicbody"
	
	sprite.frames = SpriteFrames.new()
	var id = tileset.find_tile_by_name("orc")
	var tex = tileset.tile_get_texture(id)
	var reg = tileset.tile_get_region(id)
	texture.atlas = tex
	texture.region = reg
	
	sprite.frames.add_animation("idle")
	sprite.frames.add_frame("idle",texture)
	sprite.animation = "idle"
	
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(sprite.frames.get_frame("idle",0).region.size.x/2,sprite.frames.get_frame("idle",0).region.size.y/2)
	var own_id = kinematicbody.create_shape_owner(self)
	kinematicbody.shape_owner_add_shape(own_id,shape)
	
	$".".add_child(kinematicbody)
	$"kinematicbody".add_child(sprite)
	
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
