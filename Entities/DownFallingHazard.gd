extends "res://Entities/HazardBase.gd"

export var start_motion = Vector2(0,0)
export var max_velocity = 500
export var gravity = 500

signal destroyed()

var gravity_vector
var motion

var shape

func _ready():
	gravity_vector = gravity * Vector2(0,1)
	motion = start_motion
	shape = find_node("CollisionShape2D")
		
func _physics_process(delta):
	motion += gravity_vector * delta;
	
	$AnimatedSprite.rotation = motion.angle() - PI / 2
		
	var collision = move_and_collide((delta * motion).clamped(max_velocity))
	if collision != null:
		if collision.collider.name == "Player":
			PlayerVariables.hit_player()
		
		disable()
		emit_signal("destroyed")
		
func restart():
	motion = start_motion
	enable()
	
func disable():
	set_process(false)
	set_physics_process(false)
	shape.disabled = true
	
	hide()

func enable():
	set_process(true)
	set_physics_process(true)
	
	if shape != null:
		shape.disabled = false
	
	show()
