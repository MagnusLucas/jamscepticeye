extends AnimatedSprite2D

const BULLET = preload("uid://w3nfpcl0rh5n") # res://scenes/bullet.tscn
var bullet
@onready var cooldown = $Timer

var player_index = 0
var gun_direction = Vector2.ZERO
var bullet_speed = 200
var deadzone = 0.2
# var for keyboard+mouse or controller
@export var gun_length = 20
var gun_angle = 0

func _ready():
	player_index = get_parent().player_index

func _physics_process(_delta):
	# gun pointy [
	#gun_direction = Vector2.ZERO
	# ^ initially put down? or hidden
	
	gun_direction.x = Input.get_joy_axis(player_index, JOY_AXIS_RIGHT_X)
	gun_direction.y = Input.get_joy_axis(player_index, JOY_AXIS_RIGHT_Y)
	
	# deadzone
	if absf(gun_direction.x) < deadzone:
		gun_direction.x = 0
	if absf(gun_direction.y) < deadzone:
		gun_direction.y = 0
	
	# look_at() for mouse pos
	if not gun_direction.is_zero_approx():
		look_at(global_position + gun_direction)
		gun_angle = get_angle_to(global_position + gun_direction)
	# ] gun pointy
	
	# shooty
	if Input.is_joy_button_pressed(player_index, JOY_BUTTON_RIGHT_SHOULDER) and cooldown.time_left == 0:
		bullet = BULLET.instantiate()
		bullet.global_position = global_position + Vector2.RIGHT.rotated(rotation) * gun_length
		bullet.rotation = rotation
		add_child(bullet)
		play("shoot")
		cooldown.start()
