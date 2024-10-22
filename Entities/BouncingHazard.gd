extends "HazardBase.gd"

export var move_speed = 100
export var start_direction = 0

var motion

func _ready():
	motion = move_speed * Vector2(1,0).rotated(deg2rad(start_direction))

func _physics_process(delta):
	
	var collision = move_and_collide(motion * delta, true, true, true)
	if collision != null:
		if collision.collider.name == "Player":
			PlayerVariables.hit_player()
		else:
			motion = motion.bounce(collision.normal).normalized() * move_speed
		
	move_and_collide(motion * delta)
