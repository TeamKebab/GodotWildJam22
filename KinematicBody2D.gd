extends KinematicBody2D


# Declare member variables here.
const GRAVITY = 20
const MAX_SPEED = 500
const ACCELERATION = 20
const JUMP_HEIGHT = 600
const ROTATION = PI / 2

var motion = Vector2()
var up = Vector2(0, -1)

# Called when the node enters the scene tree for the first time.
func _ready():
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
		
	if input_right():
		var left = up.rotated(PI/2)
		motion = (motion + left * ACCELERATION).clamped(MAX_SPEED)
		
		$Sprite.flip_h = false
		$Sprite.play("Run")	
	elif input_left():
		var right = up.rotated(-PI/2)
		motion = (motion + right * ACCELERATION).clamped(MAX_SPEED)
		
		$Sprite.flip_h = true
		$Sprite.play("Run")	
	else:
		friction = true
				
	if is_on_floor():	
		if input_jump():
			motion = JUMP_HEIGHT * up
			
		if friction == true:
			motion = lerp(motion, Vector2(0,0), 0.2)
			$Sprite.play("Idle")
	else:
		#motion = lerp(motion, Vector2(0,0), 0.02)
		
		var angle = motion.angle_to(up)
		var motion_cos = cos(angle)
		
		if motion_cos > 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		
	motion = move_and_slide(motion, up)
	
	pass

func input_right():
	if abs(up.y) > abs(up.x):
		if up.y < 0 and Input.is_action_pressed("ui_right"):
			return true
		if up.y > 0 and Input.is_action_pressed("ui_left"):
			return true
	else:
		if up.x < 0 and Input.is_action_pressed("ui_up"):
			return true
		if up.x > 0 and Input.is_action_pressed("ui_down"):
			return true

func input_left():
	if abs(up.y) > abs(up.x):
		if up.y < 0 and Input.is_action_pressed("ui_left"):
			return true
		if up.y > 0 and Input.is_action_pressed("ui_right"):
			return true		
	else:
		if up.x < 0 and Input.is_action_pressed("ui_down"):
			return true
		if up.x > 0 and Input.is_action_pressed("ui_up"):
			return  true

func input_jump():
	if abs(up.y) > abs(up.x):
		if up.y < 0 and Input.is_action_just_pressed("ui_up"):
			return true
		if up.y > 0 and Input.is_action_pressed("ui_down"):
			return true
	else:
		if up.x < 0 and Input.is_action_pressed("ui_left"):
			return true
		if up.x > 0 and Input.is_action_pressed("ui_right"):
			return true
