extends KinematicBody2D

const GRAVITY = 1000
const MAX_SPEED = 500
const ROTATION = PI / 2

var start_position
var start_motion
var start_up
 
var motion
var up

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.connect("animation_finished", self, "finished_animation")	
	start_position = position	
	start_motion = Vector2()
	start_up = Vector2(0,-1).rotated(rotation)
	
	restart()

func _physics_process(delta):
	motion += (-GRAVITY * up) * delta;
	
	if Input.is_action_just_pressed("ui_right"):
		change_gravity(ROTATION)
		$Sprite.flip_h = false
		$Sprite.play("Jump")
		
	elif Input.is_action_just_pressed("ui_left"):
		change_gravity(-ROTATION)
		
		$Sprite.flip_h = true
		$Sprite.play("Jump")

				
	if is_on_floor():	
		motion = lerp(motion, Vector2(0,0), 0.2)
		
		if motion.length() < 0.5:			
			$Sprite.play("Idle")
	else:
		motion = lerp(motion, Vector2(0,0), 0.02)
		
	motion = move_and_slide(motion, up)
	
	if motion.length() < 0.01:			
		$Sprite.play("Idle")
	
	var slide_count = get_slide_count()
	if slide_count > 0:
		for idx in get_slide_count():
			var collision = get_slide_collision(idx)
			var collider = collision.get_collider()
			if collider.has_method("get_damage"):
				PlayerVariables.change_player_health(-collider.get_damage())
				restart()
				break
					
	pass

func change_gravity(rotation):
	up = up.rotated(rotation)
	rotate(rotation)
	PlayerVariables.change_gravity(-GRAVITY * up)
		
func finished_animation():
	if $Sprite.animation == "Jump":
		$Sprite.play("Run");
	pass

func restart():
	position = start_position
	motion = start_motion
	up = start_up
	rotation = 0
	$Sprite.flip_h = false
	
	PlayerVariables.change_gravity(-GRAVITY * up)
	
	pass
