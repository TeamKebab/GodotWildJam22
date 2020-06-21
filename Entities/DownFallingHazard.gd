extends "res://Entities/HazardBase.gd"

export var start_motion = Vector2(0,0)
export var max_velocity = 500
export var gravity = 500

signal destroyed()

var gravity_vector
var motion

func _ready():
	gravity_vector = gravity * Vector2(0,1)
	motion = start_motion
	
func _physics_process(delta):
	motion += gravity_vector * delta;
	
	$AnimatedSprite.rotation = motion.angle() - PI / 2
		
	var collision = move_and_collide((delta * motion).clamped(max_velocity))
	if collision != null:
		hide()
		emit_signal("destroyed")
	
func restart():
	motion = start_motion
	show()
	
