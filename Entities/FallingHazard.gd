extends "res://Entities/HazardBase.gd"

export var start_motion = Vector2(0,0)
export var max_velocity = 500

signal destroyed()

var gravity
var motion

func _ready():
	PlayerVariables.connect("gravity_changed", self, "_on_Player_gravity_changed")
	
	gravity = PlayerVariables.gravity
	motion = start_motion
	
func _on_Player_gravity_changed(new_gravity):
	gravity = new_gravity	

func _physics_process(delta):
	motion += gravity * delta;
	
	$AnimatedSprite.rotation = motion.angle() - PI / 2
	
	var collision = move_and_collide(motion * delta, true, true, true)
	if collision != null and collision.collider.name != "Player":
		print("destroyed")
		emit_signal("destroyed")
		hide()
		set_process(false)
	
	position = position + (delta * motion).clamped(max_velocity)
	
func restart():	
	motion = start_motion
	show()
	
