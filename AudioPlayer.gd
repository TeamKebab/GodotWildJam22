extends Node

signal sound_stopped(sound, finished)

const SOUNDS = {
	"loading_player": "res://Sounds/win-1.wav",
	"choose_character": "res://Sounds/select-player.wav",
	"die": "res://Sounds/explode-6.wav"
}

const MUSIC = {
	"levels": "res://Sounds/robolution_theme_1.ogg",
	"start_screen": "res://Sounds/select_character.ogg",
	"win_screen": "res://Sounds/game_over.ogg"
}

var music_player
var music_enabled = true setget set_play_music
var music_position = 0.0
var current_music = ""
var music = {}

var sounds_player
var sounds_enabled = true setget set_play_sounds
var current_sound = ""
var sounds = {}

func _ready():
	init_music_player()
	init_sounds_player()
	
func init_music_player():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	for music_key in MUSIC:
		music[music_key] = load(MUSIC[music_key])
		music[music_key].set_loop(true)
		
func init_sounds_player():	
	sounds_player = AudioStreamPlayer.new()
	add_child(sounds_player)
	
	sounds_player.connect("finished", self, "_on_sounds_player_finished")
	
	for sound_key in SOUNDS:
		sounds[sound_key] = load(SOUNDS[sound_key])

func _on_sounds_player_finished():
	emit_signal("sound_stopped", current_sound, true)
		
func set_play_music(play):
	music_enabled = play
	if play:
		music_player.volume_db = 0
	else:
		music_player.volume_db = -80

func set_play_sounds(play):
	sounds_enabled = play
	if play:
		sounds_player.volume_db = 0
	else:
		sounds_player.volume_db = -80
			
func play_sound(name):
	if sounds.has(name):
		if sounds_player.playing:
			emit_signal("sound_stopped", current_sound, false)
		current_sound = name
		sounds_player.stream = sounds[name]
		sounds_player.play()
	
func play_music(name):
	if not music.has(name):
		name = "levels"
	
	if name != current_music:
		current_music = name
		music_player.stream = music[current_music]
		music_player.play()
