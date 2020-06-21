extends Control

func _ready():
	AudioPlayer.play_music("start_screen")

func _input(event):
	if event.is_action_pressed("ui_left"):
		choose_character("Lefty")
	elif event.is_action_pressed("ui_right"):
		choose_character("Righty")
	elif event.is_action_pressed("ui_up"):
		choose_character("God")

func choose_character(character):
	PlayerVariables.choose_character(character)	
