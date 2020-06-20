extends Node

signal deaths_changed(player_deaths)
signal gravity_changed(new_gravity)

var player_deaths = 0
var gravity = Vector2(0,0)
var character = "Righty"

var music_player
var music_position = 0.0

var sounds_player
var play_sounds = true

var sounds = {}

func _ready():
	set_current_scene()
	
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	var music = load("res://Sounds/robolution_theme_1.ogg")
	music.set_loop(true)
	
	music_player.stream = music
	music_player.play()
	
	sounds_player = AudioStreamPlayer.new()
	add_child(sounds_player)
	
	sounds["loading_player"] = load("res://Sounds/win-1.wav")
	sounds["choose_character"] = load("res://Sounds/select-player.wav")
	
func set_play_music(play_music):
	if play_music:
		music_player.play(music_position)
	else:
		music_position = music_player.get_playback_position()
		music_player.stop()

func set_play_sounds(play):
	play_sounds = play
			
func play_sound(sound):
	if sounds.has(sound) and play_sounds:
		sounds_player.stream = sounds[sound]
		sounds_player.play()
		
func change_player_deaths(health_change):
	player_deaths -= health_change
	emit_signal("deaths_changed", player_deaths)

func change_gravity(new_gravity):
	gravity = new_gravity
	emit_signal("gravity_changed", new_gravity)

func choose_character(new_character):
	character = new_character
	play_sound("choose_character")
	load_level("res://Levels/Level1.tscn")
	
func can_turn_left():
	return character == "Lefty" or character == "God"
	
func can_turn_right():
	return character == "Righty" or character == "God"
	
func restart():
	player_deaths = 0
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
	
	
