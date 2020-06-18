extends KinematicBody2D

const GRAVITY = 1000
const MAX_SPEED = 500
const ROTATION = PI / 2

var start_position
var start_motion
var start_up
 
var motion
var up

var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	$LeftySprite.connect("animation_finished", self, "finished_animation")	
	$RightySprite.connect("animation_finished", self, "finished_animation")	
	
	start_position = position	
	start_motion = Vector2()
	start_up = Vector2(0,-1).rotated(rotation)
	
	set_character()
	restart()

func _physics_process(delta):
	motion += (-GRAVITY * up) * delta;
	
	if PlayerVariables.can_turn_right() and Input.is_action_just_pressed("ui_right"):
		change_gravity(ROTATION)
		sprite.play("Turn")
		
	elif PlayerVariables.can_turn_left() and Input.is_action_just_pressed("ui_left"):
		change_gravity(-ROTATION)
		sprite.play("Turn")

				
	if is_on_floor():	
		motion = lerp(motion, Vector2(0,0), 0.2)
		
		if motion.length() < 0.5:			
			sprite.play("Idle")
	else:
		motion = lerp(motion, Vector2(0,0), 0.02)
		
	motion = move_and_slide(motion, up)
	
	if motion.length() < 0.01:			
		sprite.play("Idle")
	
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
	if sprite.animation == "Turn":
		sprite.play("Fall");
	pass

func set_character():
	if PlayerVariables.character == "Lefty":
		sprite = $RightySprite
		
		$RightySprite.hide()
		$RightyShape.hide()
		$RightyShape.disabled = true
		
		$LeftySprite.show()
		$LeftyShape.show()
		$LeftyShape.disabled = false
	else:
		sprite = $LeftySprite
		$LeftySprite.hide()
		$LeftySprite.hide()
		$LeftyShape.disabled = true
		
		$RightySprite.show()
		$RightySprite.show()
		$RightyShape.disabled = false

func restart():
	position = start_position
	motion = start_motion
	up = start_up
	rotation = 0
	
	PlayerVariables.change_gravity(-GRAVITY * up)
