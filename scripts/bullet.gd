extends Node2D

var speed = 200
var bullet_type : String = "star"

func _physics_process(delta):
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta
	$AnimatedSprite.play(bullet_type)
