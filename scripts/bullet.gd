extends Node2D

var speed = 200

func _physics_process(delta):
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta
