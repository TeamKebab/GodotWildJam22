extends Node

const START_HEALTH = 5

signal health_changed(player_health)
signal gravity_changed(new_gravity)

var player_health = START_HEALTH
var gravity = Vector2(0,0)
var character = "Righty"

var music_player

func _ready():
	set_current_scene()
	
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	var music_file = "res://Sounds/robolution_theme_1.ogg"
	var music = load(music_file)
	music.set_loop(true)
	
	music_player.stream = music
	music_player.play()
	
func change_player_health(health_change):
	player_health += health_change
	emit_signal("health_changed", player_health)
	
	if player_health <= 0:
		load_level("res://GameOver.tscn")

func change_gravity(new_gravity):
	gravity = new_gravity
	emit_signal("gravity_changed", new_gravity)

func choose_character(new_character):
	character = new_character
	load_level("res://Levels/Level1.tscn")
	
func can_turn_left():
	return character == "Lefty" or character == "God"
	
func can_turn_right():
	return character == "Righty" or character == "God"
	
func restart():
	player_health = START_HEALTH
	load_level("res://StartScreen.tscn")
	
##### SCENE LOADER

var current_scene

func set_current_scene():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func load_level(level_path):
	call_deferred("_deferred_load_level", level_path)

func _deferred_load_level(path):
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
	
