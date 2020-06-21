extends KinematicBody2D

const GRAVITY = 1000
const MAX_SPEED = 500
const ROTATION = PI / 2
const ROTATION_SPEED = 15 * PI
const NO_MOVEMENT_SECONDS = 1
const INVULNERABILITY_SECONDS = 3

var start_position
var start_motion
var start_up
 
var motion
var up
var time_since_last_death

var sprite
var spawnSprite

# Called when the node enters the scene tree for the first time.
func _ready():	
	start_position = position	
	start_motion = Vector2()
	start_up = Vector2(0,-1).rotated(rotation)
	
	sprite = $RightySprite
	
	set_character()
	restart()
	time_since_last_death = INVULNERABILITY_SECONDS

	spawnSprite = get_parent().find_node("SpawnerSprite")
	spawnSprite.play("Loading")
	
		
func _physics_process(delta):
	time_since_last_death += delta
	
	if time_since_last_death > NO_MOVEMENT_SECONDS:
		process_inputs()
		spawnSprite.play("Waiting")
	else:
		spawnSprite.play("Loading")
	
	rotate_with_gravity(delta)	
	move(delta)
	
	if time_since_last_death > INVULNERABILITY_SECONDS:
		sprite.visible = true
		collide_with_hazards()
	else:
		sprite.visible = !sprite.visible


func process_inputs():
	if PlayerVariables.can_turn_right() and Input.is_action_just_pressed("ui_right"):
		change_gravity(ROTATION)
		sprite.play("Turn")
		
	elif PlayerVariables.can_turn_left() and Input.is_action_just_pressed("ui_left"):
		change_gravity(-ROTATION)
		sprite.play("Turn")
		
	if Input.is_action_just_pressed("ui_cancel"):
		PlayerVariables.restart()
		
func change_gravity(rotation):
	up = up.rotated(rotation)
	PlayerVariables.change_gravity(-GRAVITY * up)

func move(delta):	
	motion += (-GRAVITY * up) * delta;
				
	if is_on_floor():	
		motion = lerp(motion, Vector2(0,0), 0.2)
		
		if motion.length() < 0.5:			
			sprite.play("Idle")
	else:
		motion = lerp(motion, Vector2(0,0), 0.02)
		
	motion = move_and_slide(motion, up)
	
	if motion.length() < 0.01:			
		sprite.play("Idle")
			
func rotate_with_gravity(delta):
	var desired_rotation = up.angle() + PI/2
	
	if rotation != desired_rotation:
		var rotation_direction = desired_rotation - rotation
		
		if rotation_direction > PI:
			rotation_direction = rotation_direction - 2 * PI
		if rotation_direction < -PI:
			rotation_direction = 2 * PI - rotation_direction
			
		if rotation_direction > 0:
			rotate(min(rotation_direction, ROTATION_SPEED * delta))
		else:
			rotate(max(rotation_direction, -ROTATION_SPEED * delta))
	
func collide_with_hazards():	
	var slide_count = get_slide_count()
	if slide_count > 0:
		for idx in get_slide_count():
			var collision = get_slide_collision(idx)
			var collider = collision.get_collider()
			if collider.has_method("get_damage"):
				PlayerVariables.change_player_deaths(-collider.get_damage())
				revive()
				break

func finished_animation():
	if sprite.animation == "Turn":
		sprite.play("Fall");
	pass

func set_character():
	if PlayerVariables.character == "Lefty":
		set_sprite($LeftySprite)
		$RightyShape.disabled = true
		$LeftyShape.disabled = false
	else:
		set_sprite($RightySprite)
		$LeftyShape.disabled = true
		$RightyShape.disabled = false

func set_sprite(new_sprite):
	sprite.hide()
	sprite.disconnect("animation_finished", self, "finished_animation")
	
	sprite = new_sprite
	sprite.show()
	sprite.play("Fall")
	sprite.connect("animation_finished", self, "finished_animation")	
	
func revive():	
	time_since_last_death = 0
	AudioPlayer.play_sound("loading_player")
	restart()
	
func restart():
	position = start_position
	motion = start_motion
	up = start_up
	rotation = 0
	
	PlayerVariables.change_gravity(-GRAVITY * up)
