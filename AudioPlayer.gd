extends Node

const SOUNDS = {
	"loading_player": "res://Sounds/win-1.wav",
	"choose_character": "res://Sounds/select-player.wav"
}

const LEVELS_MUSIC = "res://Sounds/robolution_theme_1.ogg"

var music_player
var play_music = true setget set_play_music
var music_position = 0.0

var sounds_player
var play_sounds = true setget set_play_sounds

var sounds = {}

func _ready():
	init_music_player()
	init_sounds_player()
	
func init_music_player():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	var music = load(LEVELS_MUSIC)
	music.set_loop(true)
	
	music_player.stream = music
	music_player.play()
		
func init_sounds_player():	
	sounds_player = AudioStreamPlayer.new()
	add_child(sounds_player)
	
	for sound_key in SOUNDS:
		sounds[sound_key] = load(SOUNDS[sound_key])
		
func set_play_music(play):
	play_music = play
	
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
	
