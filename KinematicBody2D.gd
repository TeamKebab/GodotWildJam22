extends KinematicBody2D


# Declare member variables here.
const GRAVITY = 20
const MAX_SPEED = 500
const ROTATION = PI / 4

var motion = Vector2()
var up = Vector2(0, -1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.connect("animation_finished", self, "finished_animation")	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	motion += -GRAVITY * up;
	
	var friction = false;
	
	if Input.is_action_just_pressed("ui_select"):
		up = up.rotated(ROTATION)
		rotate(ROTATION)
		
	if Input.is_action_just_pressed("ui_right"):
		up = up.rotated(ROTATION)
		rotate(ROTATION)
		$Sprite.flip_h = false
		$Sprite.play("Jump")
		
	elif Input.is_action_just_pressed("ui_left"):
		up = up.rotated(-ROTATION)
		rotate(-ROTATION)
		
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
	pass

func finished_animation():
	if $Sprite.animation == "Jump":
		$Sprite.play("Run");
	pass
