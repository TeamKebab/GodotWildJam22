extends "HazardBase.gd"

export var move_speed = 100
export (NodePath) var patrol_path

var patrol_points
var patrol_index = 0

func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()

func _physics_process(delta):
	if !patrol_path:
		return
	
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 1:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	
	print("size: ", patrol_points.size())
	print("index: ", patrol_index)
	var velocity = (target - position).normalized() * move_speed
	velocity = move_and_slide(velocity)
	
	$AnimatedSprite.rotation = velocity.angle()
	if (velocity.x < 0.5):
		$AnimatedSprite.flip_v = true
	else:
		$AnimatedSprite.flip_v = false
