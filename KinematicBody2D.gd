extends KinematicBody2D


# Declare member variables here.
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 20
const JUMP_HEIGHT = -600

var motion = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false;
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")	
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")	
	else:
		friction = true
				
	if is_on_floor():	
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
			$Sprite.play("Idle")
	else:
		motion.x = lerp(motion.x, 0, 0.02)
		
		if motion.y < 0:
			if Input.is_action_just_pressed("ui_up"):
				motion.y = min(motion.y, JUMP_HEIGHT * 0.7)
				
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		
	motion = move_and_slide(motion, UP)
	
	pass
