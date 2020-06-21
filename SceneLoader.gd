extends Node

const LEVELS = [
#	"res://Levels/Tests/MeteoriteTest.tscn",
#	"res://Levels/Tests/MoscaTest.tscn",
	"res://Levels/IHateMyLife.tscn",
	"res://Levels/RainingMeatballs.tscn",
	"res://Levels/TheEasyOne.tscn",
	"res://Levels/MoscaIntro.tscn",
	"res://Levels/TheFunBegins.tscn",
	"res://Levels/WhereYouLearnToCount.tscn",
	"res://Levels/SpikeHell.tscn"
]

const WIN_SCREEN = "res://Win.tscn"
const START_SCREEN = "res://StartScreen.tscn"

var level_index = 0
var current_scene

func _ready():
	set_current_scene()
	
func start_screen():
	load_level(START_SCREEN)

func first_level():
	level_index = 0
	load_level(LEVELS[level_index])
	AudioPlayer.play_music("levels")
	
func next_level():
	level_index += 1
	
	if level_index == LEVELS.size():
		load_level(WIN_SCREEN)
		AudioPlayer.play_music("win_screen")
	else:
		load_level(LEVELS[level_index])

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
	
	
