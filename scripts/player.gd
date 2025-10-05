extends CharacterBody2D

@export var player_index = 0
@export var player_animations_set : SpriteFrames
var input_velocity = Vector2.ZERO
var speed = 200
var deadzone = 0.2
# var for keyboard or controller?

func _ready():
	var sprite_frames_path : String = "res://assets/player/player" + str(player_index + 1) + "_animations.tres"
	var PLAYER_ANIMATIONS = load(sprite_frames_path)
	$PlayerSprite.sprite_frames = PLAYER_ANIMATIONS
	$PlayerSprite.play()

func _physics_process(delta):
	# movement [
	input_velocity = Vector2.ZERO
	
	input_velocity.x = Input.get_joy_axis(player_index, JOY_AXIS_LEFT_X)
	input_velocity.y = Input.get_joy_axis(player_index, JOY_AXIS_LEFT_Y)
	
	# deadzone
	if absf(input_velocity.x) < deadzone:
		input_velocity.x = 0
	if absf(input_velocity.y) < deadzone:
		input_velocity.y = 0
	
	#if Input.is_joy_button_pressed(player_index, JOY_BUTTON_DPAD_LEFT) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_DPAD_LEFT):
		input_velocity.x = -1
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_DPAD_RIGHT):
		input_velocity.x = 1
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_DPAD_UP):
		input_velocity.y = -1
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_DPAD_DOWN):
		input_velocity.y = 1
	
	position += input_velocity * speed * delta
	# ] movement
	
	# setting animation
	if not input_velocity.is_zero_approx():
		$PlayerSprite.play("walk")
	else:
		$PlayerSprite.play("idle")
	
	# setting sprite rotation
	$PlayerSprite.look_at(global_position + input_velocity)
